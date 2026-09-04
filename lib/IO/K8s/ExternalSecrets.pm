package IO::K8s::ExternalSecrets;
# ABSTRACT: external-secrets CRD resource map provider for IO::K8s
our $VERSION = '1.108';
use Moo;
with 'IO::K8s::Role::ResourceMap';

sub upstream_version { 'v2.10.0' }  # external-secrets/external-secrets

# Upstream CRD manifests for the pinned upstream_version, consumed by
# maint/crd-drift-check.pl. Data only -- no fetching happens here. `base`
# + each `files` entry is the raw manifest URL; the checker caches each
# under spec/crd/ExternalSecrets/ (path separators flattened to '_').
sub crd_sources {
    my $v = __PACKAGE__->upstream_version;
    return {
        status => 'ok',
        base   => "https://raw.githubusercontent.com/external-secrets/external-secrets/$v/deploy/crds",
        files  => [
            'bundle.yaml',
        ],
    };
}

sub resource_map {
    return {
        # external-secrets.io/v1 -- the graduated, served+storage version for
        # all four of these Kinds at the pin (v1beta1 still ships in the CRD
        # manifest but is served: false everywhere -- not modeled, see POD).
        ExternalSecret        => 'ExternalSecrets::V1::ExternalSecret',
        SecretStore           => 'ExternalSecrets::V1::SecretStore',
        ClusterSecretStore    => 'ExternalSecrets::V1::ClusterSecretStore',
        ClusterExternalSecret => 'ExternalSecrets::V1::ClusterExternalSecret',
        # external-secrets.io/v1alpha1 -- PushSecret has not graduated to v1
        # at this pin; v1alpha1 is its only served version.
        PushSecret            => 'ExternalSecrets::V1alpha1::PushSecret',
        # external-secrets.io/v1alpha1 -- ClusterPushSecret is the
        # cluster-scoped sibling of PushSecret; its spec wraps the same
        # PushSecretSpec tree (spec.pushSecretSpec) rather than re-modeling it.
        ClusterPushSecret     => 'ExternalSecrets::V1alpha1::ClusterPushSecret',
    };
}

1;

__END__

=head1 SYNOPSIS

    my $k8s = IO::K8s->new(with => ['IO::K8s::ExternalSecrets']);

    my $store = $k8s->new_object('SecretStore',
        metadata => { name => 'aws-store', namespace => 'default' },
        spec => {
            provider => {
                aws => {
                    service => 'SecretsManager',
                    region  => 'eu-west-1',
                    auth    => { jwt => { serviceAccountRef => { name => 'my-sa' } } },
                },
            },
        },
    );

    my $es = $k8s->new_object('ExternalSecret',
        metadata => { name => 'db-creds', namespace => 'default' },
        spec => {
            secretStoreRef => { name => 'aws-store', kind => 'SecretStore' },
            target         => { name => 'db-creds' },
            data           => [ { secretKey => 'password', remoteRef => { key => 'prod/db/password' } } ],
        },
    );

    print $es->to_yaml;

=head1 DESCRIPTION

Resource map provider for L<external-secrets|https://external-secrets.io/>
Custom Resource Definitions. Registers 6 resource_map entries covering
C<external-secrets.io/v1> (C<ExternalSecret>, C<SecretStore>,
C<ClusterSecretStore>, C<ClusterExternalSecret>) and
C<external-secrets.io/v1alpha1> (C<PushSecret>, C<ClusterPushSecret>),
matching upstream external-secrets v2.10.0.

Every Kind is modeled to full depth: C<spec> (and, where upstream declares
one, C<status>) is a typed object graph of further
C<IO::K8s::ExternalSecrets::V1::*> / C<IO::K8s::ExternalSecrets::V1alpha1::*>
classes, one per upstream Go structure, named after the upstream Go types
(C<github.com/external-secrets/external-secrets/apis/externalsecrets/v1>
and C<.../v1alpha1>). Embedded core Kubernetes types are referenced, not
re-modeled -- e.g. a condition list reuses a shipped C<Core::V1>/C<Meta::V1>
condition-shaped class rather than a per-Kind copy (D5's C<reuse_core>), and
several small cross-provider reference structs -- L<IO::K8s::ExternalSecrets::V1::SecretKeySelector>
(external-secrets' own, cross-namespace-capable variant, not
C<Core::V1::SecretKeySelector>), L<IO::K8s::ExternalSecrets::V1::ServiceAccountSelector>,
L<IO::K8s::ExternalSecrets::V1::CAProvider> -- are the literal same upstream
Go type referenced from dozens of places (every provider's own auth block,
for the first two) rather than one copy per backend.

C<SecretStore> and C<ClusterSecretStore> embed the identical upstream
C<SecretStoreSpec>/C<SecretStoreStatus> Go types (verified byte-identical
schema before writing these classes) and so share the very same
L<IO::K8s::ExternalSecrets::V1::SecretStoreSpec> class -- including its
C<provider> field, L<IO::K8s::ExternalSecrets::V1::SecretStoreProvider>,
a 43-member union of every backend the CRD's C<MinProperties=1>/
C<MaxProperties=1> validation restricts to exactly one of (AWS, Azure Key
Vault, HashiCorp Vault, GCP Secret Manager, Kubernetes, Akeyless, and so on
-- see L</"Included CRDs (external-secrets.io/v1)"> below for the full
list), each backend's own auth/reference structs modeled to full depth in
turn. C<ClusterExternalSecret> similarly embeds the literal same
C<ExternalSecretSpec> Go type C<ExternalSecret> uses for its own C<spec>
(as C<spec.externalSecretSpec>), so
L<IO::K8s::ExternalSecrets::V1::ExternalSecretSpec> and everything below it
(C<ExternalSecretData>, C<ExternalSecretTarget>,
L<IO::K8s::ExternalSecrets::V1::ExternalSecretTemplate>, ...) is one shared
tree of classes reachable from both Kinds. C<ClusterPushSecret> mirrors
that: it embeds the literal same C<PushSecretSpec> Go type C<PushSecret>
uses for its own C<spec> (as C<spec.pushSecretSpec>), so
L<IO::K8s::ExternalSecrets::V1alpha1::PushSecretSpec> and everything below
it is shared rather than re-modeled; its own wrapper fields
(C<namespaceSelectors>, C<pushSecretMetadata>, C<pushSecretName>,
C<refreshTime>) live on
L<IO::K8s::ExternalSecrets::V1alpha1::ClusterPushSecretSpec>. Its
C<status.conditions> reuses the same L<IO::K8s::Api::Core::V1::NamespaceCondition>
class C<PushSecretStatus> already reuses for the identical
C<PushSecretStatusCondition> Go type.

B<Scope (D9):> C<ClusterSecretStore>, C<ClusterExternalSecret> and
C<ClusterPushSecret> are cluster-scoped upstream (C<spec.scope: Cluster>)
and do not compose L<IO::K8s::Role::Namespaced>; C<ExternalSecret>,
C<SecretStore> and C<PushSecret> are namespaced upstream and do.

B<Served versions:> the CRD manifest at this pin still ships a deprecated
C<external-secrets.io/v1beta1> track for C<ExternalSecret>, C<SecretStore>
and C<ClusterSecretStore> (and a deprecated C<v1beta1> for
C<ClusterExternalSecret>), but every one of those entries is
C<served: false> in the manifest -- an API server at this upstream version
would reject a request naming it. Only the served version of each Kind is
modeled: C<v1> for C<ExternalSecret>, C<SecretStore>, C<ClusterSecretStore>
and C<ClusterExternalSecret>; C<v1alpha1> for C<PushSecret> and
C<ClusterPushSecret>, neither of which has graduated to C<v1> at this pin.

Not loaded by default -- opt in via the C<with> constructor parameter of
L<IO::K8s> or by calling C<< $k8s->add('IO::K8s::ExternalSecrets') >> at
runtime.

=head2 Included CRDs (external-secrets.io/v1)

ExternalSecret, SecretStore, ClusterSecretStore, ClusterExternalSecret

C<SecretStore>/C<ClusterSecretStore>'s C<spec.provider> backends: AWS,
AzureKV, Akeyless, BitwardenSecretsManager, Vault, OVHcloud, GCPSM, Oracle,
IBM, YandexCertificateManager, YandexLockbox, Github, GitLab, OnePassword,
OnePasswordSDK, Webhook, Kubernetes, CRD, Fake, Senhasegura, Scaleway,
Doppler, Previder, Onboardbase, KeeperSecurity, Conjur, Delinea,
SecretServer, Chef, Pulumi, Fortanix, PasswordDepot, Passbolt, DVLS,
Infisical, Beyondtrust, BeyondtrustWorkloadCredentials, CloudruSM,
Volcengine, Ngrok, Barbican, NebiusMysterybox, OpenBao.

=head2 Included CRDs (external-secrets.io/v1alpha1)

PushSecret, ClusterPushSecret

=seealso

L<IO::K8s>

L<external-secrets documentation|https://external-secrets.io/latest/>

L<external-secrets API reference|https://external-secrets.io/latest/api/spec/>

=cut
