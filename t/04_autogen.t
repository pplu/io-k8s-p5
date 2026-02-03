#!/usr/bin/env perl
# Tests for auto-generation of classes from OpenAPI spec
#
# Run with mock (default):
#   prove -l t/04_autogen.t
#
# Run against live cluster:
#   TEST_IO_K8S_KUBECONFIG=/path/to/kubeconfig prove -l t/04_autogen.t

use strict;
use warnings;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib";

use IO::K8s;
use IO::K8s::AutoGen;

# Test 1: Basic AutoGen module functionality
subtest 'AutoGen module basics' => sub {
    # def_to_class conversion
    is(
        IO::K8s::AutoGen::def_to_class('helm.cattle.io.v1.HelmChart'),
        'IO::K8s::_AUTOGEN::helm::cattle::io::v1::HelmChart',
        'def_to_class with default namespace'
    );

    is(
        IO::K8s::AutoGen::def_to_class('helm.cattle.io.v1.HelmChart', 'MyApp::K8s'),
        'MyApp::K8s::helm::cattle::io::v1::HelmChart',
        'def_to_class with custom namespace'
    );

    # class_to_def conversion
    is(
        IO::K8s::AutoGen::class_to_def('IO::K8s::_AUTOGEN::helm::cattle::io::v1::HelmChart'),
        'helm.cattle.io.v1.HelmChart',
        'class_to_def'
    );

    # is_autogen check
    ok(IO::K8s::AutoGen::is_autogen('IO::K8s::_AUTOGEN::foo::Bar'), 'is_autogen true');
    ok(IO::K8s::AutoGen::is_autogen('IO::K8s::_AUTOGEN_abc123::foo::Bar'), 'is_autogen with id');
    ok(!IO::K8s::AutoGen::is_autogen('IO::K8s::Api::Core::V1::Pod'), 'is_autogen false');
};

# Test 2: IO::K8s attributes
subtest 'IO::K8s autogen attributes' => sub {
    my $k8s = IO::K8s->new;
    ok(!$k8s->has_openapi_spec, 'no openapi_spec by default');
    is_deeply($k8s->class_namespaces, [], 'empty class_namespaces by default');
    like($k8s->_autogen_namespace, qr/^IO::K8s::_AUTOGEN_[0-9a-f]+$/, 'unique autogen namespace');

    # Different instances get different namespaces
    my $k8s2 = IO::K8s->new;
    isnt($k8s->_autogen_namespace, $k8s2->_autogen_namespace, 'different instances, different namespaces');
};

# Test 3: Class generation from schema
subtest 'class generation from schema' => sub {
    IO::K8s::AutoGen::clear_cache();

    my $schema = {
        type => 'object',
        properties => {
            apiVersion => { type => 'string' },
            kind => { type => 'string' },
            name => { type => 'string' },
            replicas => { type => 'integer' },
            enabled => { type => 'boolean' },
            tags => { type => 'array', items => { type => 'string' } },
            labels => { type => 'object', additionalProperties => { type => 'string' } },
        },
    };

    my $class = IO::K8s::AutoGen::get_or_generate(
        'test.example.v1.MyResource',
        $schema,
        {},
        'IO::K8s::_AUTOGEN_test',
    );

    is($class, 'IO::K8s::_AUTOGEN_test::test::example::v1::MyResource', 'correct class name');
    ok($class->can('new'), 'class has new');
    ok($class->can('TO_JSON'), 'class has TO_JSON');
    ok($class->isa('IO::K8s::Resource'), 'inherits from IO::K8s::Resource');

    # Create instance
    my $obj = $class->new(
        apiVersion => 'test.example/v1',
        kind => 'MyResource',
        name => 'test-resource',
        replicas => 3,
        enabled => 1,
        tags => ['foo', 'bar'],
        labels => { app => 'test' },
    );

    ok($obj, 'created instance');
    is($obj->kind, 'MyResource', 'kind attribute');
    is($obj->replicas, 3, 'integer attribute');
    is($obj->enabled, 1, 'boolean attribute');
    is_deeply($obj->tags, ['foo', 'bar'], 'array attribute');
    is_deeply($obj->labels, { app => 'test' }, 'hash attribute');

    # Serialize
    my $json = $obj->TO_JSON;
    is($json->{kind}, 'MyResource', 'TO_JSON kind');
    is($json->{replicas}, 3, 'TO_JSON replicas');
};

# Test 4: Live cluster tests (if kubeconfig provided)
SKIP: {
    skip 'Set TEST_IO_K8S_KUBECONFIG for live cluster tests', 1
        unless $ENV{TEST_IO_K8S_KUBECONFIG};

    # Need Kubernetes::REST for this
    eval { require Kubernetes::REST::Kubeconfig };
    if ($@) {
        skip 'Kubernetes::REST::Kubeconfig not available', 1;
    }

    subtest 'live cluster auto-generation' => sub {

        my $kc = Kubernetes::REST::Kubeconfig->new(
            kubeconfig_path => $ENV{TEST_IO_K8S_KUBECONFIG},
        );
        my $api = $kc->api;

        # Fetch OpenAPI spec
        my $resp = $api->_request('GET', '/openapi/v2');
        is($resp->status, 200, 'fetched OpenAPI spec');

        require JSON::MaybeXS;
        my $spec = JSON::MaybeXS->new->decode($resp->content);
        ok($spec->{definitions}, 'spec has definitions');

        # Create IO::K8s with openapi_spec
        IO::K8s::AutoGen::clear_cache();
        my $k8s = IO::K8s->new(
            openapi_spec => $spec,
        );

        # Try to find a CRD type (k3s Addon or HelmChart)
        my @crd_types;
        for my $def (keys %{$spec->{definitions}}) {
            if ($def =~ /^io\.cattle\.(k3s|helm)/) {
                push @crd_types, $def;
            }
        }

        if (!@crd_types) {
            pass('No CRD types found in cluster - skipping CRD tests');
            return;
        }

        diag "Found CRD types: " . join(", ", @crd_types[0..2]) . "...";

        # Try to fetch and inflate an Addon
        my $addon_resp = $api->_request('GET', '/apis/k3s.cattle.io/v1/addons');
        if ($addon_resp->status == 200) {
            my $list = JSON::MaybeXS->new->decode($addon_resp->content);
            if (@{$list->{items} // []}) {
                my $addon_data = $list->{items}[0];
                diag "Testing with Addon: " . $addon_data->{metadata}{name};

                my $addon = $k8s->inflate($addon_data);
                ok($addon, 'inflated Addon');
                isa_ok($addon, 'IO::K8s::Resource');
                ok(IO::K8s::AutoGen::is_autogen(ref($addon)), 'class is auto-generated');
                is($addon->kind, 'Addon', 'kind is Addon');
                ok($addon->metadata, 'has metadata');
                is($addon->metadata->name, $addon_data->{metadata}{name}, 'metadata.name matches');

                # Roundtrip test
                my $roundtrip = $addon->TO_JSON;
                is($roundtrip->{kind}, $addon_data->{kind}, 'roundtrip kind');
                is($roundtrip->{apiVersion}, $addon_data->{apiVersion}, 'roundtrip apiVersion');
                is($roundtrip->{metadata}{name}, $addon_data->{metadata}{name}, 'roundtrip metadata.name');
            }
        }

        # Report generated classes
        my @generated = IO::K8s::AutoGen::generated_classes();
        diag "Generated " . scalar(@generated) . " classes";
    };
}

# Test 5: class_namespaces priority
subtest 'class_namespaces priority' => sub {
    # Create a fake user class
    {
        package MyApp::K8s::Api::Core::V1::Pod;
        use Moo;
        sub custom_method { 'from_user_class' }
        1;
    }

    my $k8s = IO::K8s->new(
        class_namespaces => ['MyApp::K8s'],
    );

    # Should find user class first
    my $class = $k8s->expand_class('Pod');
    is($class, 'MyApp::K8s::Api::Core::V1::Pod', 'user class found first');
    is($class->custom_method, 'from_user_class', 'is the user class');

    # Without class_namespaces, should find built-in
    my $k8s2 = IO::K8s->new;
    my $class2 = $k8s2->expand_class('Pod');
    is($class2, 'IO::K8s::Api::Core::V1::Pod', 'built-in class found');
};

done_testing;
