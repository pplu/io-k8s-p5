#!/usr/bin/env perl
# D10: IO::K8s::CRD turns a CustomResourceDefinition manifest into one class
# per served version; IO::K8s->add_crd registers them (qualified keys for
# every version, the short name on the storage version).
use strict;
use warnings;
use Test::More;
use Test::Exception;
use FindBin;

use IO::K8s;
use IO::K8s::CRD;

my $fixture = "$FindBin::Bin/data/crd-knob.yaml";

subtest 'load accepts every input form' => sub {
    my $from_path = IO::K8s::CRD->load($fixture);
    is(scalar @$from_path, 1, 'one CRD from a path');
    is($from_path->[0]{spec}{names}{kind}, 'Knob', 'parsed');

    open my $fh, '<', $fixture or die $!;
    my $text = do { local $/; <$fh> };
    is_deeply(IO::K8s::CRD->load($text), $from_path, 'same from YAML text');
    is_deeply(IO::K8s::CRD->load($from_path->[0]), $from_path, 'same from a hashref');

    my $k8s = IO::K8s->new;
    my $obj = $k8s->inflate($from_path->[0]);
    isa_ok($obj, 'IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::CustomResourceDefinition');
    my $from_obj = IO::K8s::CRD->load($obj);
    is($from_obj->[0]{spec}{versions}[1]{schema}{openAPIV3Schema}{properties}{spec}{properties}{mode}{enum}[0], 'fast',
        'from an object, through TO_JSON');
    is(scalar @{ IO::K8s::CRD->load([ $fixture, $from_path->[0] ]) }, 2, 'an arrayref of inputs concatenates');

    throws_ok { IO::K8s::CRD->load("apiVersion: v1\nkind: Pod\nmetadata:\n  name: x\n") }
        qr/document 1 is a 'Pod', not a CustomResourceDefinition/, 'wrong kind dies, names the document';
    throws_ok { IO::K8s::CRD->load({ kind => 'CustomResourceDefinition', spec => { group => 'g' } }) }
        qr/without spec\.group \/ spec\.names\.kind \/ spec\.versions/, 'incomplete CRD dies';
    throws_ok { IO::K8s::CRD->load(undef) } qr/needs a CustomResourceDefinition/, 'undef dies';
    throws_ok {
        IO::K8s::CRD->load({
            apiVersion => 'apiextensions.k8s.io/v1',
            kind       => 'CustomResourceDefinition',
            metadata   => { name => 'x' },
            spec       => { group => 'g', names => { kind => 'X', plural => 'xs' }, versions => [] },
        });
    } qr/without spec\.group \/ spec\.names\.kind \/ spec\.versions/, 'empty versions array dies the same way';
};

subtest 'served_versions skips unserved and marks storage' => sub {
    my ($crd) = @{ IO::K8s::CRD->load($fixture) };
    my $v = IO::K8s::CRD->served_versions($crd);
    is_deeply([ map { $_->{api_version} } @$v ], [ 'opts.example.com/v1alpha1', 'opts.example.com/v1' ], 'v0 is not served');
    is_deeply([ map { $_->{storage} } @$v ], [ 0, 1 ], 'storage flag');
    is($v->[1]{name}, 'v1', 'name');
    ok($v->[1]{schema}{properties}{spec}, 'schema carried');
};

subtest 'served_versions accepts a quoted "true"/"false" and rejects a malformed flag' => sub {
    my ($crd) = @{ IO::K8s::CRD->load($fixture) };
    my @versions = @{ $crd->{spec}{versions} };

    # v0 is unserved in the fixture (served: false); flip it to the quoted
    # string form and confirm it now counts as served.
    my %quoted_crd = %$crd;
    $quoted_crd{spec} = {
        %{ $crd->{spec} },
        versions => [ @versions[0, 1], { %{ $versions[2] }, served => 'true' } ],
    };
    my $v = IO::K8s::CRD->served_versions(\%quoted_crd);
    is_deeply([ map { $_->{name} } @$v ], [ 'v1alpha1', 'v1', 'v0' ], 'served: "true" (quoted string) counts as served');

    # A value _normalize_bool cannot read as true/false must not be
    # swallowed into "not served" -- it has to fail loudly instead.
    my %malformed_crd = %$crd;
    $malformed_crd{spec} = {
        %{ $crd->{spec} },
        versions => [ { %{ $versions[0] }, served => [ 1, 2 ] }, $versions[1] ],
    };
    throws_ok { IO::K8s::CRD->served_versions(\%malformed_crd) }
        qr/spec\.versions\[0\]\.served is not a boolean/, 'a malformed served value dies loudly, naming the index and field';
};

subtest 'generate falls back to the LAST served version when none marks storage' => sub {
    my ($crd) = @{ IO::K8s::CRD->load($fixture) };
    my %no_storage_crd = %$crd;
    $no_storage_crd{spec} = {
        %{ $crd->{spec} },
        versions => [ map { +{ %$_, storage => 0 } } @{ $crd->{spec}{versions} } ],
    };
    my $k8s = IO::K8s->new;
    my $classes = IO::K8s::CRD->generate(\%no_storage_crd, $k8s->_autogen_namespace);
    is($classes->{storage}, 'opts.example.com/v1', 'v1 (the last served version) is picked, not v1alpha1 (the first)');
};

subtest 'generate: scope Cluster does not compose Role::Namespaced' => sub {
    my ($crd) = @{ IO::K8s::CRD->load($fixture) };
    my %cluster_crd = %$crd;
    $cluster_crd{spec} = { %{ $crd->{spec} }, scope => 'Cluster' };
    my $k8s = IO::K8s->new;
    my $classes = IO::K8s::CRD->generate(\%cluster_crd, $k8s->_autogen_namespace);
    my $storage_class = $classes->{ $classes->{storage} };
    ok(!$storage_class->does('IO::K8s::Role::Namespaced'), 'Cluster-scoped generated class is not Namespaced');
};

subtest 'add_crd registers every served version and the storage short name' => sub {
    my $k8s = IO::K8s->new;
    my $reg = $k8s->add_crd($fixture);
    is_deeply([ sort keys %$reg ], [ 'Knob' ], 'one Kind');
    is($reg->{Knob}{storage}, 'opts.example.com/v1', 'storage version');
    my $v1  = $reg->{Knob}{'opts.example.com/v1'};
    my $v1a = $reg->{Knob}{'opts.example.com/v1alpha1'};
    like($v1,  qr/^IO::K8s::_AUTOGEN_[0-9a-f]+::opts::example::com::v1::Knob$/, 'v1 class in the instance namespace');
    like($v1a, qr/::v1alpha1::Knob$/, 'v1alpha1 class');
    is($k8s->expand_class('Knob'), $v1, 'short name -> storage version');
    is($k8s->expand_class('Knob', 'opts.example.com/v1alpha1'), $v1a, 'qualified lookup -> other version');
    is($k8s->expand_class('opts.example.com/v1/Knob'), $v1, 'domain-qualified string');
    is($v1->api_version, 'opts.example.com/v1', 'api_version');
    is($v1->kind, 'Knob', 'kind');
    is($v1->resource_plural, 'knobs', 'resource_plural from names.plural');
    ok($v1->does('IO::K8s::Role::Namespaced'), 'Namespaced scope');
    ok($v1->does('IO::K8s::Role::APIObject'), 'top-level object');
};

subtest 'objects from the registered classes are typed to full depth' => sub {
    my $k8s = IO::K8s->new;
    $k8s->add_crd($fixture);
    my $knob = $k8s->new_object('Knob',
        metadata => { name => 'k', namespace => 'd' },
        spec => {
            mode => 'fast', replicas => 2,
            limit => { average => 10, period => '5s' },
            routes => [ { match => 'a', weight => 1 } ],
            size => '10Gi',
            extra => { anything => 1 },
        },
    );
    isa_ok($knob->spec->limit, ref($knob) . '::Spec::Limit');
    isa_ok($knob->spec->routes->[0], ref($knob) . '::Spec::RoutesItem');
    is($knob->spec->size, '10Gi', 'x-kubernetes-int-or-string -> IntOrStr');
    is($knob->spec->_k8s_attr_info->{size}{is_int_or_string}, 1,
        'size is registered as IntOrStr at the registry level, not merely holding a string value');
    is_deeply($knob->TO_JSON->{spec}{extra}, { anything => 1 }, 'preserve-unknown object is opaque and round-trips');
    throws_ok { $k8s->new_object('Knob', metadata => { name => 'k' }, spec => { mode => 'slow' }) } qr/not one of: fast, safe/, 'enum';
    throws_ok { $k8s->new_object('Knob', metadata => { name => 'k' }, spec => { mode => 'fast', replicas => 9 }) } qr/above the maximum 5/, 'range';
    throws_ok { $k8s->new_object('Knob', metadata => { name => 'k' }, spec => { mode => 'fast', limit => { period => 'x' } }) } qr/does not match the pattern/, 'pattern below the top level';
    # required lists are recorded for the schema (required => 'schema', step 2's
    # ruling), never enforced on a generated class: a cluster returns
    # status: {} for a fresh object no matter what the status schema requires.
    is(ref($knob)->_k8s_attr_info->{spec}{required}, 1, 'top-level required recorded');
    is($knob->spec->_k8s_attr_info->{mode}{required}, 1, 'nested required recorded');
    lives_ok { $k8s->new_object('Knob', metadata => { name => 'k' }, spec => {}) } 'a missing required field does not fail construction';
    lives_ok { $k8s->inflate({ apiVersion => 'opts.example.com/v1', kind => 'Knob', metadata => { name => 'k' }, spec => { mode => 'fast' }, status => {} }) }
        'a cluster document with an empty status inflates';
    my $old = $k8s->new_object('Knob', { metadata => { name => 'o' }, spec => { mode => 'anything' } }, 'opts.example.com/v1alpha1');
    is($old->api_version, 'opts.example.com/v1alpha1', 'the other served version is its own class');
    is($old->TO_JSON->{spec}{mode}, 'anything', 'with its own, looser schema');
};

subtest 'a provider registered first keeps the short name' => sub {
    my $k8s = IO::K8s->new;
    $k8s->add({ Knob => '+IO::K8s::Api::Core::V1::Pod' });   # stands in for a provider class
    my $reg = $k8s->add_crd($fixture);
    is($k8s->expand_class('Knob'), 'IO::K8s::Api::Core::V1::Pod', 'first registration wins the short name');
    is($k8s->expand_class('opts.example.com/v1/Knob'), $reg->{Knob}{'opts.example.com/v1'}, 'the CRD class is reachable by its qualified key');
};

subtest 'two instances do not share generated classes' => sub {
    my $a = IO::K8s->new; my $b = IO::K8s->new;
    my $ra = $a->add_crd($fixture); my $rb = $b->add_crd($fixture);
    isnt($ra->{Knob}{'opts.example.com/v1'}, $rb->{Knob}{'opts.example.com/v1'}, 'different namespaces');
};

done_testing;
