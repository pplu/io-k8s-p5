#!/usr/bin/env perl
# karr #31: expand_class must resolve a resource_map short-name key on the
# GVK path, gated on the mapped class confirming the requested apiVersion.
#
# Bug: IO::K8s->new(resource_map => { %default_map, StaticWebSite =>
# '+My::StaticWebSite' }) accepted the map, but the GVK paths in
# expand_class only consulted the domain-qualified '$api_version/$Kind'
# keys when an apiVersion was supplied. A short-name key ('StaticWebSite')
# was silently ignored, so
#
#     inflate({ kind => 'StaticWebSite', apiVersion => 'homelab.example.com/v1' })
#
# died with "Cannot resolve Kubernetes GVK" while
#
#     expand_class('StaticWebSite')        # no apiVersion
#
# worked fine.
#
# Design under test: both GVK paths fall back to the short-name key, but
# only when the mapped class's own api_version() matches the request.
# A class without an api_version() method, or with a mismatching version,
# fails closed (undef) — karr #17 stays intact.
#
# Red/green against the CURRENT lib: the 'inflate() with apiVersion',
# 'new_object with apiVersion', 'expand_class("$av/$kind")' and 'live
# resource_map mutation' subtests are RED (the fallback does not exist
# yet). The version-mismatch, no-api_version-method and existing-behaviour
# subtests are GREEN.
#
# Pure local fixtures — no network, no cluster.

use strict;
use warnings;
use Test::More;
use Test::Exception;
use lib 'lib';
use IO::K8s;

# ----------------------------------------------------------------------------
# Test-local CRD classes.
#   My::StaticWebSite  — kind() matches the bug report's wire kind.
#   My::TestCRD        — the generic mini-CRD shape (kind derived from the
#                        class name, so the map key must be 'TestCRD').
#   My::NoApiVersion   — has kind() but NO api_version() at all: not
#                        verifiable, so the fallback must fail closed.
# ----------------------------------------------------------------------------

{
    package My::StaticWebSite;
    use IO::K8s::APIObject
        api_version     => 'homelab.example.com/v1',
        resource_plural => 'staticwebsites';
    k8s spec => { Str => 1 };
    1;
}

{
    package My::TestCRD;
    use IO::K8s::APIObject
        api_version     => 'homelab.example.com/v1',
        resource_plural => 'testcrds';
    k8s spec => { Str => 1 };
    1;
}

{
    package My::NoApiVersion;
    use IO::K8s::Resource;
    sub kind { 'NoApiVersion' }
    1;
}

# The reported reproduction: the built-in map plus short-name CRD keys.
my %map = (
    %{ IO::K8s->default_resource_map },
    StaticWebSite => '+My::StaticWebSite',
    TestCRD      => '+My::TestCRD',
);

subtest 'inflate() with apiVersion resolves short-name CRD key' => sub {
    my $api = IO::K8s->new(resource_map => \%map);

    my $obj;
    lives_ok {
        $obj = $api->inflate({
            kind       => 'StaticWebSite',
            apiVersion => 'homelab.example.com/v1',
            metadata   => { name => 'my-site' },
            spec       => { domain => 'blog.example.com' },
        });
    } 'inflate kind + apiVersion does not die';
    SKIP: {
        skip 'inflate did not resolve yet (karr #31 not fixed)', 5
            unless defined $obj;
        isa_ok($obj, 'My::StaticWebSite', 'inflated object class');
        is($obj->kind, 'StaticWebSite', 'inflated kind');
        is($obj->api_version, 'homelab.example.com/v1', 'inflated api_version');
        is($obj->metadata->name, 'my-site', 'inflated metadata name');
        is($obj->spec->{domain}, 'blog.example.com', 'inflated spec');
    }
};

subtest 'new_object with apiVersion resolves short-name CRD key' => sub {
    my $api = IO::K8s->new(resource_map => \%map);

    my $obj;
    lives_ok {
        $obj = $api->new_object('TestCRD',
            { metadata => { name => 'my-crd' }, spec => { foo => 'bar' } },
            'homelab.example.com/v1',
        );
    } 'new_object($kind, {...}, $api_version) does not die';
    SKIP: {
        skip 'new_object did not resolve yet (karr #31 not fixed)', 4
            unless defined $obj;
        isa_ok($obj, 'My::TestCRD', 'new_object object class');
        is($obj->kind, 'TestCRD', 'new_object kind');
        is($obj->api_version, 'homelab.example.com/v1', 'new_object api_version');
        is($obj->metadata->name, 'my-crd', 'new_object metadata name');
    }
};

subtest 'expand_class("$av/$kind") resolves short-name CRD key' => sub {
    my $api = IO::K8s->new(resource_map => \%map);

    is($api->expand_class('homelab.example.com/v1/TestCRD'), 'My::TestCRD',
        'domain-qualified string falls back to short-name key (TestCRD)');
    is($api->expand_class('homelab.example.com/v1/StaticWebSite'), 'My::StaticWebSite',
        'domain-qualified string falls back to short-name key (StaticWebSite)');
};

subtest 'version mismatch fails closed' => sub {
    my $api = IO::K8s->new(resource_map => \%map);

    is($api->expand_class('StaticWebSite', 'wrong.example.com/v2'), undef,
        'expand_class with mismatched apiVersion returns undef (fail closed)');

    throws_ok {
        $api->inflate({
            kind       => 'StaticWebSite',
            apiVersion => 'wrong.example.com/v2',
            metadata   => { name => 'x' },
        });
    } qr/Cannot resolve Kubernetes GVK: kind 'StaticWebSite', apiVersion 'wrong\.example\.com\/v2'/,
        'inflate with mismatched apiVersion dies with GVK error';
};

subtest 'mapped class without api_version() fails closed' => sub {
    my $api = IO::K8s->new(resource_map => {
        %{ IO::K8s->default_resource_map },
        NoApiVersion => '+My::NoApiVersion',
    });

    is($api->expand_class('NoApiVersion', 'whatever.io/v1'), undef,
        'class without api_version() cannot be verified -> undef (fail closed)');
};

subtest 'live resource_map mutation after construction' => sub {
    my $api = IO::K8s->new;    # no resource_map at construction
    $api->resource_map->{StaticWebSite} = '+My::StaticWebSite';

    my $obj;
    lives_ok {
        $obj = $api->inflate({
            kind       => 'StaticWebSite',
            apiVersion => 'homelab.example.com/v1',
            metadata   => { name => 'live' },
        });
    } 'live-mutated map: inflate with apiVersion does not die';
    SKIP: {
        skip 'live-mutated inflate did not resolve yet (karr #31 not fixed)', 3
            unless defined $obj;
        isa_ok($obj, 'My::StaticWebSite', 'live-mutated inflate object class');
        is($obj->kind, 'StaticWebSite', 'live-mutated inflate kind');
        is($obj->api_version, 'homelab.example.com/v1', 'live-mutated inflate api_version');
    }
};

subtest 'existing behaviour unchanged' => sub {
    my $api = IO::K8s->new(resource_map => \%map);

    is($api->expand_class('Pod', 'apps/v1'), undef,
        'Pod is core/v1 — apps/v1 request stays undef (fallback must not false-hit)');
    is($api->expand_class('Pod', 'v1'), 'IO::K8s::Api::Core::V1::Pod',
        'qualified key still takes precedence');
    is($api->expand_class('Pod'), 'IO::K8s::Api::Core::V1::Pod',
        'short name without apiVersion unchanged');
    is($api->expand_class('StaticWebSite'), 'My::StaticWebSite',
        'short name without apiVersion still resolves (baseline from bug report)');
};

done_testing;
