#!/usr/bin/env perl
# D9: Class->to_crd builds a CustomResourceDefinition from a typed class's
# attribute registry -- the exact inverse of IO::K8s::AutoGen's
# schema-to-DSL mapping (_schema_to_type_spec). See docs/superpowers/specs/
# 2026-09-03-crd-design.md, decision D9.
use strict;
use warnings;
use Test::More;
use Test::Exception;
use Scalar::Util qw( blessed reftype );

use IO::K8s;
use IO::K8s::CRD;
use IO::K8s::CertManager::V1::Order;

# --- fixture: every branch of the reverse mapping -------------------------

{
    package Test79::Item;
    use IO::K8s::Resource;

    k8s label  => Str, 'required';
    k8s weight => Int;

    1;
}

{
    package Test79::Widget;
    use IO::K8s::APIObject
        api_version     => 'crdstep5.example.com/v1',
        resource_plural => 'widgets';
    with 'IO::K8s::Role::Namespaced';

    k8s name      => Str, { required => 1, description => 'Name of the widget' };
    k8s replicas  => Int, { minimum => 0, maximum => 5 };
    k8s ratio     => Num;
    k8s ready     => Bool;
    k8s flexible  => IntOrStr;
    k8s cpu       => Quantity;
    k8s startedAt => Time;
    k8s tags      => [Str];
    k8s ports     => [Int];
    k8s flags     => [Bool];
    k8s rows      => [ {} ];
    k8s matrix    => [ [] ];
    k8s limit     => '+Test79::Item';
    k8s items     => ['+Test79::Item'];
    k8s scores    => { Int => 1 };
    k8s extras    => { '+Test79::Item' => 1 };
    k8s labels    => { Str => 1 };
    k8s mode      => Str, { enum => [qw(fast safe)], pattern => qr/\A[a-z]+\z/ };
    k8s note      => Str, { nullable => 1 };
    k8s blob      => Str, { preserve_unknown => 1 };
    k8s greeting  => Str, { default => 'hi' };

    1;
}

{
    package Test79::ClusterThing;
    use IO::K8s::APIObject
        api_version     => 'crdstep5.example.com/v1',
        resource_plural => 'clusterthings';

    k8s note => Str;

    1;
}

{
    package Test79::Cycle;
    use IO::K8s::Resource;

    k8s self => '+Test79::Cycle';

    1;
}

# JSON::MaybeXS booleans are blessed scalar refs; flatten them to plain 1/0
# on both sides of is_deeply so the comparison does not depend on whichever
# backend (Cpanel::JSON::XS, JSON::XS, JSON::PP) MaybeXS picked, or on
# singleton identity.
sub _flatten_bools {
    my ($val) = @_;
    return { map { $_ => _flatten_bools($val->{$_}) } keys %$val } if ref $val eq 'HASH';
    return [ map { _flatten_bools($_) } @$val ]                    if ref $val eq 'ARRAY';
    return ($val ? 1 : 0) if blessed($val) && (reftype($val) // '') eq 'SCALAR';
    return $val;
}

my $ITEM_SCHEMA = {
    type       => 'object',
    properties => {
        label  => { type => 'string' },
        weight => { type => 'integer' },
    },
    required => ['label'],
};

subtest '_schema_for_class mirrors every AutoGen branch in reverse' => sub {
    my $schema = IO::K8s::CRD::_schema_for_class('Test79::Widget');
    my $expected = {
        type       => 'object',
        required   => ['name'],
        properties => {
            apiVersion => { type => 'string' },
            kind       => { type => 'string' },
            metadata   => { type => 'object' },
            name       => { type => 'string', description => 'Name of the widget' },
            replicas   => { type => 'integer', minimum => 0, maximum => 5 },
            ratio      => { type => 'number' },
            ready      => { type => 'boolean' },
            flexible   => { 'x-kubernetes-int-or-string' => 1 },
            cpu        => { type => 'string' },   # is_quantity -> string: documented lossy edge
            startedAt  => { type => 'string', format => 'date-time' },
            tags       => { type => 'array', items => { type => 'string' } },
            ports      => { type => 'array', items => { type => 'integer' } },
            flags      => { type => 'array', items => { type => 'boolean' } },
            rows       => { type => 'array', items => { type => 'object', 'x-kubernetes-preserve-unknown-fields' => 1 } },
            matrix     => { type => 'array', items => { type => 'array' } },
            limit      => $ITEM_SCHEMA,
            items      => { type => 'array', items => $ITEM_SCHEMA },
            scores     => { type => 'object', additionalProperties => { type => 'integer' } },
            extras     => { type => 'object', additionalProperties => $ITEM_SCHEMA },
            labels     => { type => 'object', 'x-kubernetes-preserve-unknown-fields' => 1 },
            mode       => { type => 'string', enum => [qw(fast safe)], pattern => '\A[a-z]+\z' },
            note       => { type => 'string', nullable => 1 },
            blob       => { type => 'string', 'x-kubernetes-preserve-unknown-fields' => 1 },
            greeting   => { type => 'string', default => 'hi' },
        },
    };
    is_deeply(_flatten_bools($schema), $expected, 'openAPIV3Schema matches the registry, field for field');
};

subtest 'cycle guard: a self-referencing class does not recurse forever' => sub {
    my $schema = IO::K8s::CRD::_schema_for_class('Test79::Cycle');
    is_deeply(_flatten_bools($schema), {
        type       => 'object',
        properties => {
            self => { type => 'object', 'x-kubernetes-preserve-unknown-fields' => 1 },
        },
    }, 'the repeat on the recursion path becomes an opaque stub instead of looping');
};

subtest 'Class->to_crd: identity, scope, envelope' => sub {
    my $ns_crd = Test79::Widget->to_crd;
    isa_ok($ns_crd, 'IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::CustomResourceDefinition');
    is($ns_crd->spec->scope, 'Namespaced', 'Namespaced Kind -> spec.scope Namespaced');
    is($ns_crd->spec->group, 'crdstep5.example.com', 'spec.group from api_version');
    is($ns_crd->spec->names->plural, 'widgets', 'spec.names.plural from resource_plural');
    is($ns_crd->spec->names->kind, 'Widget', 'spec.names.kind from kind');
    is($ns_crd->spec->names->singular, 'widget', 'spec.names.singular lc(kind)');
    is($ns_crd->spec->names->listKind, 'WidgetList', 'spec.names.listKind');
    is($ns_crd->metadata->name, 'widgets.crdstep5.example.com', 'metadata.name is plural.group');

    my $version = $ns_crd->spec->versions->[0];
    is($version->name, 'v1', 'version name from api_version');
    is($version->served, 1, 'served true');
    is($version->storage, 1, 'storage true');
    isa_ok($version->schema->openAPIV3Schema,
        'IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::JSONSchemaProps',
        'the schema is a real typed JSONSchemaProps object, not a bare hashref');
    ok(exists $version->schema->openAPIV3Schema->TO_JSON->{properties}{name}, 'schema content reachable through the typed object');

    my $cluster_crd = Test79::ClusterThing->to_crd;
    is($cluster_crd->spec->scope, 'Cluster', 'no Namespaced role -> spec.scope Cluster');
};

subtest 'round trip: a shipped provider Kind survives to_crd -> add_crd' => sub {
    my $crd = IO::K8s::CertManager::V1::Order->to_crd;
    my $k8s = IO::K8s->new;
    my $reg = $k8s->add_crd($crd);
    my $regen_class = $reg->{Order}{ $reg->{Order}{storage} };
    ok($regen_class, 'add_crd(Class->to_crd) registers the Kind again');

    my $orig_spec_class  = IO::K8s::CertManager::V1::Order->_k8s_attr_info->{spec}{class};
    my $regen_spec_class = $regen_class->_k8s_attr_info->{spec}{class};
    is_deeply(
        [ sort keys %{ $orig_spec_class->_k8s_attr_info } ],
        [ sort keys %{ $regen_spec_class->_k8s_attr_info } ],
        'regenerated spec field set matches the original',
    );

    my $orig_status_class  = IO::K8s::CertManager::V1::Order->_k8s_attr_info->{status}{class};
    my $regen_status_class = $regen_class->_k8s_attr_info->{status}{class};
    is_deeply(
        [ sort keys %{ $orig_status_class->_k8s_attr_info } ],
        [ sort keys %{ $regen_status_class->_k8s_attr_info } ],
        'regenerated status field set matches the original',
    );
    is($regen_status_class->_k8s_attr_info->{failureTime}{is_time}, 1,
        'failureTime is still typed Time after the round trip (format: date-time round-trips losslessly)');
    is_deeply($regen_status_class->_k8s_attr_info->{state}{options}{enum},
        [qw(valid ready pending processing invalid expired errored)],
        'the enum on status.state survives the round trip');

    ok($regen_class->does('IO::K8s::Role::Namespaced'), 'Namespaced scope preserved through the round trip');
};

subtest 'scope: Cluster-scoped shipped Kind' => sub {
    # ClusterIssuer is cert-manager's cluster-scoped counterpart to Issuer.
    require IO::K8s::CertManager::V1::ClusterIssuer;
    my $crd = IO::K8s::CertManager::V1::ClusterIssuer->to_crd;
    is($crd->spec->scope, 'Cluster', 'ClusterIssuer -> spec.scope Cluster');
};

done_testing;
