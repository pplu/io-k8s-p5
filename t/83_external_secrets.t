#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Test::Exception;
use IO::K8s;
use IO::K8s::ExternalSecrets;

# --- All ExternalSecrets CRD classes (matching upstream external-secrets v2.10.0) ---

my %v1_classes = (
    ExternalSecret        => { plural => 'externalsecrets',        namespaced => 1 },
    SecretStore           => { plural => 'secretstores',           namespaced => 1 },
    ClusterSecretStore    => { plural => 'clustersecretstores',    namespaced => 0 },
    ClusterExternalSecret => { plural => 'clusterexternalsecrets', namespaced => 0 },
);

my %v1alpha1_classes = (
    PushSecret        => { plural => 'pushsecrets',        namespaced => 1 },
    ClusterPushSecret => { plural => 'clusterpushsecrets', namespaced => 0 },
);

# --- Load all 6 classes ---

subtest 'load all ExternalSecrets classes' => sub {
    for my $kind (sort keys %v1_classes) {
        my $class = "IO::K8s::ExternalSecrets::V1::$kind";
        use_ok($class) or BAIL_OUT("Cannot load $class");
    }
    for my $kind (sort keys %v1alpha1_classes) {
        my $class = "IO::K8s::ExternalSecrets::V1alpha1::$kind";
        use_ok($class) or BAIL_OUT("Cannot load $class");
    }
};

# --- Verify api_version, kind, resource_plural, namespaced ---

subtest 'V1 class metadata' => sub {
    for my $kind (sort keys %v1_classes) {
        my $class = "IO::K8s::ExternalSecrets::V1::$kind";
        my $info = $v1_classes{$kind};

        is($class->api_version, 'external-secrets.io/v1', "$kind api_version");
        is($class->kind, $kind, "$kind kind");
        is($class->resource_plural, $info->{plural}, "$kind resource_plural");
        if ($info->{namespaced}) {
            ok($class->does('IO::K8s::Role::Namespaced'), "$kind is namespaced");
        } else {
            ok(!$class->does('IO::K8s::Role::Namespaced'), "$kind is cluster-scoped");
        }
    }
};

subtest 'V1alpha1 class metadata' => sub {
    for my $kind (sort keys %v1alpha1_classes) {
        my $class = "IO::K8s::ExternalSecrets::V1alpha1::$kind";
        my $info = $v1alpha1_classes{$kind};

        is($class->api_version, 'external-secrets.io/v1alpha1', "$kind api_version");
        is($class->kind, $kind, "$kind kind");
        is($class->resource_plural, $info->{plural}, "$kind resource_plural");
        if ($info->{namespaced}) {
            ok($class->does('IO::K8s::Role::Namespaced'), "$kind is namespaced");
        } else {
            ok(!$class->does('IO::K8s::Role::Namespaced'), "$kind is cluster-scoped");
        }
    }
};

# --- IO::K8s::ExternalSecrets resource_map completeness ---

subtest 'IO::K8s::ExternalSecrets resource_map' => sub {
    my $provider = IO::K8s::ExternalSecrets->new;
    ok($provider->does('IO::K8s::Role::ResourceMap'), 'consumes ResourceMap role');

    my $map = $provider->resource_map;
    is(scalar keys %$map, 6, 'resource_map has 6 entries');

    for my $kind (sort keys %v1_classes) {
        ok(exists $map->{$kind}, "$kind in resource_map");
        is($map->{$kind}, "ExternalSecrets::V1::$kind", "$kind maps to correct class path");
    }
    for my $kind (sort keys %v1alpha1_classes) {
        ok(exists $map->{$kind}, "$kind in resource_map");
        is($map->{$kind}, "ExternalSecrets::V1alpha1::$kind", "$kind maps to correct class path");
    }
};

# --- new(with => ['IO::K8s::ExternalSecrets']) integration ---

subtest 'with constructor parameter' => sub {
    my $k8s = IO::K8s->new(with => ['IO::K8s::ExternalSecrets']);

    for my $kind (sort keys %v1_classes) {
        is($k8s->expand_class($kind), "IO::K8s::ExternalSecrets::V1::$kind",
            "expand_class('$kind') resolves");
    }
    for my $kind (sort keys %v1alpha1_classes) {
        is($k8s->expand_class($kind), "IO::K8s::ExternalSecrets::V1alpha1::$kind",
            "expand_class('$kind') resolves");
    }

    # Domain-qualified access
    is($k8s->expand_class('external-secrets.io/v1/SecretStore'),
        'IO::K8s::ExternalSecrets::V1::SecretStore',
        'domain-qualified V1 resolves');
    is($k8s->expand_class('external-secrets.io/v1alpha1/PushSecret'),
        'IO::K8s::ExternalSecrets::V1alpha1::PushSecret',
        'domain-qualified V1alpha1 resolves');

    # Core resources are unaffected
    is($k8s->expand_class('Secret'), 'IO::K8s::Api::Core::V1::Secret',
        'core Secret still resolves');
    is($k8s->expand_class('ConfigMap'), 'IO::K8s::Api::Core::V1::ConfigMap',
        'core ConfigMap still resolves');
};

# --- new_object + inflate round-trip (one namespaced, one cluster-scoped, at minimum) ---

subtest 'new_object and inflate round-trip' => sub {
    my $k8s = IO::K8s->new(with => ['IO::K8s::ExternalSecrets']);

    # Namespaced: ExternalSecret
    my $es = $k8s->new_object('ExternalSecret',
        metadata => { name => 'db-creds', namespace => 'default' },
        spec => {
            secretStoreRef => { name => 'aws-store', kind => 'SecretStore' },
            target         => { name => 'db-creds' },
            data           => [ { secretKey => 'password', remoteRef => { key => 'prod/db/password' } } ],
        },
    );
    isa_ok($es, 'IO::K8s::ExternalSecrets::V1::ExternalSecret');
    is($es->kind, 'ExternalSecret', 'kind');
    is($es->api_version, 'external-secrets.io/v1', 'api_version');
    isa_ok($es->metadata, 'IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta');
    is($es->metadata->name, 'db-creds', 'name');
    is($es->metadata->namespace, 'default', 'namespace');
    ok($es->does('IO::K8s::Role::Namespaced'), 'ExternalSecret is namespaced');

    my $json = $k8s->object_to_json($es);
    like($json, qr/"apiVersion":"external-secrets\.io\/v1"/, 'JSON has apiVersion');
    like($json, qr/"kind":"ExternalSecret"/, 'JSON has kind');

    my $re = $k8s->inflate($json);
    isa_ok($re, 'IO::K8s::ExternalSecrets::V1::ExternalSecret', 're-inflated');
    is($re->metadata->name, 'db-creds', 'round-trip name preserved');
    is($re->spec->data->[0]->remoteRef->key, 'prod/db/password', 'round-trip nested remoteRef.key preserved');

    # Cluster-scoped: ClusterSecretStore
    my $css = $k8s->new_object('ClusterSecretStore',
        metadata => { name => 'fake-store' },
        spec => { provider => { fake => { data => [ { key => 'x', value => 'y' } ] } } },
    );
    isa_ok($css, 'IO::K8s::ExternalSecrets::V1::ClusterSecretStore');
    ok(!$css->does('IO::K8s::Role::Namespaced'), 'ClusterSecretStore is cluster-scoped');

    my $css_re = $k8s->inflate($k8s->object_to_json($css));
    isa_ok($css_re, 'IO::K8s::ExternalSecrets::V1::ClusterSecretStore');
    is($css_re->metadata->name, 'fake-store', 'cluster-scoped round-trip');
    is($css_re->spec->provider->fake->data->[0]->value, 'y', 'cluster-scoped nested round-trip');

    # v1alpha1: PushSecret
    my $ps = $k8s->new_object('PushSecret',
        metadata => { name => 'push-1', namespace => 'default' },
        spec => {
            secretStoreRefs => [ { name => 'aws-store', kind => 'SecretStore' } ],
            selector        => { secret => { name => 'source-secret' } },
        },
    );
    isa_ok($ps, 'IO::K8s::ExternalSecrets::V1alpha1::PushSecret');
    is($ps->api_version, 'external-secrets.io/v1alpha1', 'PushSecret api_version');
    ok($ps->does('IO::K8s::Role::Namespaced'), 'PushSecret is namespaced');
    my $ps_re = $k8s->inflate($k8s->object_to_json($ps));
    isa_ok($ps_re, 'IO::K8s::ExternalSecrets::V1alpha1::PushSecret');
    is($ps_re->spec->secretStoreRefs->[0]->name, 'aws-store', 'PushSecret round-trip');
};

# --- to_yaml output ---

subtest 'to_yaml output' => sub {
    my $k8s = IO::K8s->new(with => ['IO::K8s::ExternalSecrets']);

    my $es = $k8s->new_object('ExternalSecret',
        metadata => { name => 'test-secret', namespace => 'default' },
        spec => { secretStoreRef => { name => 'aws-store' } },
    );
    my $yaml = $es->to_yaml;
    like($yaml, qr/apiVersion: external-secrets\.io\/v1/, 'YAML apiVersion');
    like($yaml, qr/kind: ExternalSecret/, 'YAML kind');
    like($yaml, qr/name: test-secret/, 'YAML name');
    like($yaml, qr/namespace: default/, 'YAML namespace');
};

# --- No collision with core K8s kinds ---

subtest 'no collision with core K8s kinds' => sub {
    my $k8s = IO::K8s->new(with => ['IO::K8s::ExternalSecrets']);

    is($k8s->expand_class('Secret'), 'IO::K8s::Api::Core::V1::Secret',
        'core Secret unaffected');
    is($k8s->expand_class('Namespace'), 'IO::K8s::Api::Core::V1::Namespace',
        'core Namespace unaffected');
};

# --- Full depth round-trip: ExternalSecret ---

subtest 'full depth round-trip: ExternalSecret' => sub {
    my $k8s = IO::K8s->new(with => ['IO::K8s::ExternalSecrets']);

    my $es = $k8s->new_object('ExternalSecret',
        metadata => { name => 'full-es', namespace => 'default' },
        spec => {
            refreshInterval => '1h',
            secretStoreRef  => { name => 'aws-store', kind => 'SecretStore' },
            target => {
                name           => 'full-es-secret',
                creationPolicy => 'Owner',
                template => {
                    type     => 'Opaque',
                    metadata => { labels => { app => 'demo' } },
                    data     => { key => '{{ .password }}' },
                    templateFrom => [ { configMap => { name => 'cm1', items => [ { key => 'k1' } ] } } ],
                },
            },
            data => [
                { secretKey => 'password', remoteRef => { key => 'prod/db/password', property => 'password' } },
            ],
            dataFrom => [
                { extract => { key => 'prod/db/all' } },
                { find => { name => { regexp => '^prod-.*' }, tags => { env => 'prod' } } },
            ],
            syncWindows => { kind => 'deny', windows => [ { schedule => '0 0 * * *', duration => '1h' } ] },
        },
    );

    isa_ok($es->spec, 'IO::K8s::ExternalSecrets::V1::ExternalSecretSpec');
    isa_ok($es->spec->secretStoreRef, 'IO::K8s::ExternalSecrets::V1::SecretStoreRef');
    isa_ok($es->spec->target, 'IO::K8s::ExternalSecrets::V1::ExternalSecretTarget');
    isa_ok($es->spec->target->template, 'IO::K8s::ExternalSecrets::V1::ExternalSecretTemplate');
    isa_ok($es->spec->target->template->templateFrom->[0], 'IO::K8s::ExternalSecrets::V1::TemplateFrom');
    isa_ok($es->spec->data->[0], 'IO::K8s::ExternalSecrets::V1::ExternalSecretData');
    isa_ok($es->spec->data->[0]->remoteRef, 'IO::K8s::ExternalSecrets::V1::ExternalSecretDataRemoteRef');
    isa_ok($es->spec->dataFrom->[0], 'IO::K8s::ExternalSecrets::V1::ExternalSecretDataFromRemoteRef');
    isa_ok($es->spec->dataFrom->[0]->extract, 'IO::K8s::ExternalSecrets::V1::ExternalSecretDataRemoteRef');
    isa_ok($es->spec->dataFrom->[1]->find, 'IO::K8s::ExternalSecrets::V1::ExternalSecretFind');
    isa_ok($es->spec->dataFrom->[1]->find->name, 'IO::K8s::ExternalSecrets::V1::FindName');
    isa_ok($es->spec->syncWindows, 'IO::K8s::ExternalSecrets::V1::ExternalSecretSyncWindows');
    isa_ok($es->spec->syncWindows->windows->[0], 'IO::K8s::ExternalSecrets::V1::ExternalSecretSyncWindowEntry');

    my $json = $es->TO_JSON;
    is($json->{spec}{target}{template}{data}{key}, '{{ .password }}', 'TO_JSON template.data.key');
    is($json->{spec}{dataFrom}[1]{find}{name}{regexp}, '^prod-.*', 'TO_JSON dataFrom find.name.regexp');

    my $re = $k8s->inflate($k8s->object_to_json($es));
    isa_ok($re, 'IO::K8s::ExternalSecrets::V1::ExternalSecret');
    is($re->spec->target->template->templateFrom->[0]->configMap->name, 'cm1',
        'JSON round-trip preserves deep templateFrom.configMap.name');
    is($re->spec->dataFrom->[0]->extract->key, 'prod/db/all',
        'JSON round-trip preserves dataFrom extract.key');
};

# --- Full depth round-trip: SecretStore / ClusterSecretStore share one Spec class ---

subtest 'full depth round-trip: SecretStore / ClusterSecretStore share one SecretStoreSpec class' => sub {
    my $k8s = IO::K8s->new(with => ['IO::K8s::ExternalSecrets']);

    my %store_spec = (
        controller    => 'my-controller',
        retrySettings => { maxRetries => 5, retryInterval => '10s' },
        provider => {
            aws => {
                service => 'SecretsManager',
                region  => 'eu-west-1',
                auth    => { jwt => { serviceAccountRef => { name => 'my-sa' } } },
            },
        },
    );

    my $store = $k8s->new_object('SecretStore',
        metadata => { name => 'aws-store', namespace => 'default' },
        spec     => { %store_spec },
    );
    my $cluster_store = $k8s->new_object('ClusterSecretStore',
        metadata => { name => 'aws-cluster-store' },
        spec     => { %store_spec, conditions => [ { namespaces => ['default', 'prod'] } ] },
    );

    isa_ok($store->spec, 'IO::K8s::ExternalSecrets::V1::SecretStoreSpec');
    isa_ok($cluster_store->spec, 'IO::K8s::ExternalSecrets::V1::SecretStoreSpec');
    is(ref($store->spec), ref($cluster_store->spec),
        'SecretStore and ClusterSecretStore share the SAME SecretStoreSpec class');

    isa_ok($store->spec->provider, 'IO::K8s::ExternalSecrets::V1::SecretStoreProvider');
    isa_ok($store->spec->provider->aws, 'IO::K8s::ExternalSecrets::V1::AWSProvider');
    isa_ok($store->spec->provider->aws->auth, 'IO::K8s::ExternalSecrets::V1::AWSAuth');
    isa_ok($store->spec->provider->aws->auth->jwt, 'IO::K8s::ExternalSecrets::V1::AWSJWTAuth');
    isa_ok($store->spec->provider->aws->auth->jwt->serviceAccountRef,
        'IO::K8s::ExternalSecrets::V1::ServiceAccountSelector');
    isa_ok($store->spec->retrySettings, 'IO::K8s::ExternalSecrets::V1::SecretStoreRetrySettings');
    isa_ok($cluster_store->spec->conditions->[0], 'IO::K8s::ExternalSecrets::V1::ClusterSecretStoreCondition');

    # A second, unrelated backend, still through the same shared union class.
    my $vault_store = $k8s->new_object('SecretStore',
        metadata => { name => 'vault-store', namespace => 'default' },
        spec => {
            provider => {
                vault => {
                    server => 'https://vault.example.com',
                    path   => 'secret',
                    version => 'v2',
                    auth => { kubernetes => { mountPath => 'kubernetes', role => 'eso-role', serviceAccountRef => { name => 'eso-sa' } } },
                },
            },
        },
    );
    isa_ok($vault_store->spec->provider->vault, 'IO::K8s::ExternalSecrets::V1::VaultProvider');
    isa_ok($vault_store->spec->provider->vault->auth, 'IO::K8s::ExternalSecrets::V1::VaultAuth');
    isa_ok($vault_store->spec->provider->vault->auth->kubernetes, 'IO::K8s::ExternalSecrets::V1::VaultKubernetesAuth');
    isa_ok($vault_store->spec->provider->vault->auth->kubernetes->serviceAccountRef,
        'IO::K8s::ExternalSecrets::V1::ServiceAccountSelector');

    my $json = $store->TO_JSON;
    is($json->{spec}{provider}{aws}{region}, 'eu-west-1', 'TO_JSON provider.aws.region');
    is($json->{spec}{retrySettings}{maxRetries}, 5, 'TO_JSON retrySettings.maxRetries');

    my $re = $k8s->inflate($k8s->object_to_json($store));
    isa_ok($re, 'IO::K8s::ExternalSecrets::V1::SecretStore');
    is($re->spec->provider->aws->auth->jwt->serviceAccountRef->name, 'my-sa',
        'JSON round-trip preserves deep AWS auth.jwt.serviceAccountRef.name');

    my $cluster_re = $k8s->inflate($k8s->object_to_json($cluster_store));
    isa_ok($cluster_re, 'IO::K8s::ExternalSecrets::V1::ClusterSecretStore');
    is($cluster_re->spec->conditions->[0]->namespaces->[1], 'prod',
        'JSON round-trip preserves ClusterSecretStore conditions.namespaces');
};

# --- Full depth round-trip: ClusterExternalSecret shares ExternalSecretSpec with ExternalSecret ---

subtest 'full depth round-trip: ClusterExternalSecret' => sub {
    my $k8s = IO::K8s->new(with => ['IO::K8s::ExternalSecrets']);

    my $ces = $k8s->new_object('ClusterExternalSecret',
        metadata => { name => 'ces-1' },
        spec => {
            externalSecretName => 'generated-es',
            namespaceSelector  => { matchLabels => { env => 'prod' } },
            namespaceSelectors => [ { matchLabels => { env => 'staging' } } ],
            externalSecretSpec => {
                secretStoreRef => { name => 'aws-store' },
                target         => { name => 'generated-es' },
            },
        },
    );

    ok(!$ces->does('IO::K8s::Role::Namespaced'), 'ClusterExternalSecret is cluster-scoped');
    isa_ok($ces->spec, 'IO::K8s::ExternalSecrets::V1::ClusterExternalSecretSpec');
    isa_ok($ces->spec->externalSecretSpec, 'IO::K8s::ExternalSecrets::V1::ExternalSecretSpec');
    is(ref($ces->spec->externalSecretSpec),
        'IO::K8s::ExternalSecrets::V1::ExternalSecretSpec',
        'ClusterExternalSecret.spec.externalSecretSpec is the SAME class ExternalSecret.spec uses');
    isa_ok($ces->spec->externalSecretSpec->secretStoreRef, 'IO::K8s::ExternalSecrets::V1::SecretStoreRef');
    isa_ok($ces->spec->namespaceSelector, 'IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::LabelSelector');
    isa_ok($ces->spec->namespaceSelectors->[0], 'IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::LabelSelector');

    my $ces_re = $k8s->inflate($k8s->object_to_json($ces));
    isa_ok($ces_re, 'IO::K8s::ExternalSecrets::V1::ClusterExternalSecret');
    is($ces_re->spec->externalSecretSpec->target->name, 'generated-es',
        'JSON round-trip preserves nested externalSecretSpec.target.name');

    # status
    my $with_status = $k8s->new_object('ClusterExternalSecret',
        metadata => { name => 'ces-2' },
        spec => { externalSecretSpec => { secretStoreRef => { name => 's1' } } },
        status => {
            conditions       => [ { type => 'Ready', status => 'True' } ],
            failedNamespaces => [ { namespace => 'kube-system', reason => 'forbidden' } ],
        },
    );
    isa_ok($with_status->status, 'IO::K8s::ExternalSecrets::V1::ClusterExternalSecretStatus');
    isa_ok($with_status->status->conditions->[0], 'IO::K8s::ExternalSecrets::V1::ClusterExternalSecretStatusCondition');
    isa_ok($with_status->status->failedNamespaces->[0], 'IO::K8s::ExternalSecrets::V1::ClusterExternalSecretNamespaceFailure');
    is($with_status->TO_JSON->{status}{failedNamespaces}[0]{reason}, 'forbidden',
        'TO_JSON status.failedNamespaces[0].reason');
};

# --- Full depth round-trip: PushSecret ---

subtest 'full depth round-trip: PushSecret' => sub {
    my $k8s = IO::K8s->new(with => ['IO::K8s::ExternalSecrets']);

    my $ps = $k8s->new_object('PushSecret',
        metadata => { name => 'push-full', namespace => 'default' },
        spec => {
            deletionPolicy  => 'Delete',
            updatePolicy    => 'Replace',
            secretStoreRefs => [ { name => 'aws-store', kind => 'SecretStore' } ],
            selector        => { secret => { name => 'source-secret' } },
            data => [
                { match => { secretKey => 'password', remoteRef => { remoteKey => 'prod/db', property => 'password' } } },
            ],
            dataTo => [
                { match => { regexp => '^db-.*' }, remoteKey => 'prod/db-bulk' },
            ],
        },
    );

    isa_ok($ps->spec, 'IO::K8s::ExternalSecrets::V1alpha1::PushSecretSpec');
    isa_ok($ps->spec->secretStoreRefs->[0], 'IO::K8s::ExternalSecrets::V1alpha1::PushSecretStoreRef');
    isa_ok($ps->spec->selector, 'IO::K8s::ExternalSecrets::V1alpha1::PushSecretSelector');
    isa_ok($ps->spec->data->[0], 'IO::K8s::ExternalSecrets::V1alpha1::PushSecretData');
    isa_ok($ps->spec->data->[0]->match, 'IO::K8s::ExternalSecrets::V1alpha1::PushSecretMatch');
    isa_ok($ps->spec->data->[0]->match->remoteRef, 'IO::K8s::ExternalSecrets::V1alpha1::PushSecretRemoteRef');
    isa_ok($ps->spec->dataTo->[0], 'IO::K8s::ExternalSecrets::V1alpha1::PushSecretDataTo');
    isa_ok($ps->spec->dataTo->[0]->match, 'IO::K8s::ExternalSecrets::V1alpha1::PushSecretDataToMatch');

    my $json = $ps->TO_JSON;
    is($json->{spec}{data}[0]{match}{remoteRef}{remoteKey}, 'prod/db', 'TO_JSON data match.remoteRef.remoteKey');

    my $re = $k8s->inflate($k8s->object_to_json($ps));
    isa_ok($re, 'IO::K8s::ExternalSecrets::V1alpha1::PushSecret');
    is($re->spec->dataTo->[0]->match->regexp, '^db-.*', 'JSON round-trip preserves dataTo match.regexp');
};

# --- Full depth round-trip: ClusterPushSecret shares PushSecretSpec with PushSecret ---

subtest 'full depth round-trip: ClusterPushSecret' => sub {
    my $k8s = IO::K8s->new(with => ['IO::K8s::ExternalSecrets']);

    my $cps = $k8s->new_object('ClusterPushSecret',
        metadata => { name => 'cps-1' },
        spec => {
            pushSecretName     => 'generated-ps',
            namespaceSelectors => [ { matchLabels => { env => 'staging' } } ],
            pushSecretMetadata => { labels => { team => 'platform' } },
            pushSecretSpec     => {
                secretStoreRefs => [ { name => 'aws-store', kind => 'SecretStore' } ],
                selector        => { secret => { name => 'source-secret' } },
            },
        },
    );

    ok(!$cps->does('IO::K8s::Role::Namespaced'), 'ClusterPushSecret is cluster-scoped');
    isa_ok($cps->spec, 'IO::K8s::ExternalSecrets::V1alpha1::ClusterPushSecretSpec');
    isa_ok($cps->spec->pushSecretSpec, 'IO::K8s::ExternalSecrets::V1alpha1::PushSecretSpec');
    is(ref($cps->spec->pushSecretSpec),
        'IO::K8s::ExternalSecrets::V1alpha1::PushSecretSpec',
        'ClusterPushSecret.spec.pushSecretSpec is the SAME class PushSecret.spec uses');
    isa_ok($cps->spec->pushSecretSpec->secretStoreRefs->[0], 'IO::K8s::ExternalSecrets::V1alpha1::PushSecretStoreRef');
    isa_ok($cps->spec->namespaceSelectors->[0], 'IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::LabelSelector');
    isa_ok($cps->spec->pushSecretMetadata, 'IO::K8s::ExternalSecrets::V1alpha1::PushSecretMetadata');

    my $json = $cps->TO_JSON;
    is($json->{spec}{pushSecretSpec}{selector}{secret}{name}, 'source-secret',
        'TO_JSON pushSecretSpec.selector.secret.name');

    my $cps_re = $k8s->inflate($k8s->object_to_json($cps));
    isa_ok($cps_re, 'IO::K8s::ExternalSecrets::V1alpha1::ClusterPushSecret');
    is($cps_re->spec->pushSecretSpec->selector->secret->name, 'source-secret',
        'JSON round-trip preserves nested pushSecretSpec.selector.secret.name');
    is($cps_re->spec->pushSecretMetadata->labels->{team}, 'platform',
        'JSON round-trip preserves pushSecretMetadata.labels');

    # status
    my $with_status = $k8s->new_object('ClusterPushSecret',
        metadata => { name => 'cps-2' },
        spec => {
            pushSecretSpec => {
                secretStoreRefs => [ { name => 's1' } ],
                selector        => { secret => { name => 'src' } },
            },
        },
        status => {
            conditions            => [ { type => 'Ready', status => 'True' } ],
            failedNamespaces      => [ { namespace => 'kube-system', reason => 'forbidden' } ],
            provisionedNamespaces => [ 'default', 'staging' ],
            pushSecretName        => 'generated-ps',
        },
    );
    isa_ok($with_status->status, 'IO::K8s::ExternalSecrets::V1alpha1::ClusterPushSecretStatus');
    isa_ok($with_status->status->conditions->[0], 'IO::K8s::Api::Core::V1::NamespaceCondition');
    isa_ok($with_status->status->failedNamespaces->[0], 'IO::K8s::ExternalSecrets::V1alpha1::ClusterPushSecretNamespaceFailure');
    is($with_status->TO_JSON->{status}{failedNamespaces}[0]{reason}, 'forbidden',
        'TO_JSON status.failedNamespaces[0].reason');
    is($with_status->TO_JSON->{status}{provisionedNamespaces}[1], 'staging',
        'TO_JSON status.provisionedNamespaces');

    my $status_re = $k8s->inflate($k8s->object_to_json($with_status));
    isa_ok($status_re, 'IO::K8s::ExternalSecrets::V1alpha1::ClusterPushSecret');
    is($status_re->status->conditions->[0]->type, 'Ready',
        'JSON round-trip preserves status.conditions[0].type');
};

done_testing;
