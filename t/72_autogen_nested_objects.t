#!/usr/bin/env perl
# D10: an inline `type: object` with properties becomes a nested class named
# after its place in the parent; array items and map values shaped that way
# too. Property-less objects and additionalProperties-only maps stay opaque
# (k55). Hash-style access on the result keeps working (blessed hash).
use strict;
use warnings;
use Test::More;
use Test::Exception;

use IO::K8s::AutoGen;
use IO::K8s;

IO::K8s::AutoGen::clear_cache();

my $schema = {
    type => 'object',
    'x-kubernetes-group-version-kind' => [ { group => 'nest.example.com', version => 'v1', kind => 'Widget' } ],
    properties => {
        apiVersion => { type => 'string' },
        kind       => { type => 'string' },
        metadata   => { type => 'object' },
        spec => {
            type => 'object',
            required => [ 'name' ],
            properties => {
                name  => { type => 'string' },
                limit => {
                    type => 'object',
                    properties => {
                        average => { type => 'integer', minimum => 0 },
                        burst   => { type => 'integer' },
                    },
                },
                routes => {
                    type  => 'array',
                    items => {
                        type => 'object',
                        properties => {
                            match    => { type => 'string' },
                            priority => { type => 'integer' },
                        },
                    },
                },
                weights => {
                    type => 'object',
                    additionalProperties => {
                        type => 'object',
                        properties => { value => { type => 'integer' } },
                    },
                },
                labels  => { type => 'object', additionalProperties => { type => 'string' } },
                blob    => { type => 'object' },
                'x-extra' => { type => 'object', properties => { on => { type => 'boolean' } } },
            },
        },
    },
};

my $ns = 'IO::K8s::_AUTOGEN_nested';
my $class = IO::K8s::AutoGen::get_or_generate('com.example.nest.v1.Widget', $schema, {}, $ns,
    api_version => 'nest.example.com/v1', kind => 'Widget', resource_plural => 'widgets', is_namespaced => 1);

subtest 'nested classes exist with path-derived names' => sub {
    my $spec = $class->_k8s_attr_info->{spec};
    ok($spec->{is_object}, 'spec is an object field');
    is($spec->{class}, "$class\::Spec", 'spec class named <Kind>::Spec');
    my $sinfo = $spec->{class}->_k8s_attr_info;
    is($sinfo->{limit}{class}, "$class\::Spec::Limit", 'object property -> <Parent>::<Prop>');
    ok($sinfo->{routes}{is_array_of_objects}, 'array of objects');
    is($sinfo->{routes}{class}, "$class\::Spec::RoutesItem", 'array items -> <Parent>::<Prop>Item');
    ok($sinfo->{weights}{is_hash_of_objects}, 'map of objects');
    is($sinfo->{weights}{class}, "$class\::Spec::WeightsValue", 'map values -> <Parent>::<Prop>Value');
    ok($sinfo->{labels}{is_hash_of_str}, 'additionalProperties: string stays an opaque map (k55)');
    ok($sinfo->{blob}{is_hash_of_str}, 'property-less object stays opaque');
    is($sinfo->{x_extra}{class}, "$class\::Spec::X_extra", 'sanitized key names the nested class');
    is($sinfo->{name}{required}, 1, 'required list applies inside the nested class');
    is($sinfo->{limit}{class}->_k8s_attr_info->{average}{options}{minimum}, 0, 'options apply below the top level');
};

subtest 'inflate builds the nested objects and round-trips' => sub {
    require JSON::PP;
    my $k8s = IO::K8s->new;
    $k8s->add({ Widget => "+$class" });
    my $doc = {
        apiVersion => 'nest.example.com/v1', kind => 'Widget',
        metadata   => { name => 'w' },
        spec => {
            name    => 'n',
            limit   => { average => 10, burst => 20 },
            routes  => [ { match => 'a', priority => 1 }, { match => 'b' } ],
            weights => { x => { value => 5 } },
            labels  => { app => 'web' },
            blob    => { anything => [ 1, 2 ] },
            'x-extra' => { on => JSON::PP::true() },
        },
    };
    my $obj = $k8s->inflate($doc);
    isa_ok($obj->spec, "$class\::Spec");
    isa_ok($obj->spec->limit, "$class\::Spec::Limit");
    isa_ok($obj->spec->routes->[1], "$class\::Spec::RoutesItem");
    isa_ok($obj->spec->weights->{x}, "$class\::Spec::WeightsValue");
    is($obj->spec->{name}, 'n', 'hash-style access on the blessed hash still works');
    my $out = $obj->TO_JSON;
    is_deeply($out->{spec}{limit}, { average => 10, burst => 20 }, 'nested object round-trips');
    is_deeply($out->{spec}{routes}[0], { match => 'a', priority => 1 }, 'array item round-trips');
    is_deeply($out->{spec}{weights}, { x => { value => 5 } }, 'map value round-trips');
    is_deeply($out->{spec}{blob}, { anything => [ 1, 2 ] }, 'opaque object round-trips');
    ok($out->{spec}{'x-extra'}{on}, 'sanitized nested key round-trips under its JSON name');
    throws_ok { $k8s->inflate({ %$doc, spec => { name => 'n', limit => { average => -1 } } }) } qr/below the minimum 0/,
        'constraints are enforced inside nested classes';
    my $k8s_strict = IO::K8s->new(strict => 1);
    $k8s_strict->add({ Widget => "+$class" });
    throws_ok { $k8s_strict->inflate({ %$doc, spec => { name => 'n', limit => { typo => 1 } } }) }
        qr/Unknown field 'typo' for \Q$class\E::Spec::Limit/, 'strict reaches nested classes';
};

subtest 'nested classes are cached per parent, not regenerated' => sub {
    my $again = IO::K8s::AutoGen::get_or_generate('com.example.nest.v1.Widget', $schema, {}, $ns,
        api_version => 'nest.example.com/v1', kind => 'Widget', resource_plural => 'widgets', is_namespaced => 1);
    is($again, $class, 'same Kind class');
    my @nested = grep { /^\Q$class\E::/ } IO::K8s::AutoGen::generated_classes();
    is(scalar @nested, 5, 'Spec, Limit, RoutesItem, WeightsValue, X_extra -- each once');
};

# Carried over from the step-2 final re-review: _field_options normalized a
# Bool default with _normalize_bool for every Bool kind, including [Bool],
# where the default is itself an arrayref -- _normalize_bool only accepts a
# scalar or scalar ref and dies on a bare ARRAY ref, which used to kill class
# generation over a malformed-looking but perfectly legal array default.
subtest 'array-of-Bool default is normalized per element, not left to die on the arrayref' => sub {
    require JSON::PP;
    IO::K8s::AutoGen::clear_cache();
    my $schema = {
        type => 'object',
        properties => {
            flags => {
                type    => 'array',
                items   => { type => 'boolean' },
                default => [ JSON::PP::true(), JSON::PP::false() ],
            },
        },
    };
    my $flag_class;
    lives_ok {
        $flag_class = IO::K8s::AutoGen::get_or_generate(
            'test.example.v1.Flaggy72', $schema, {}, 'IO::K8s::_AUTOGEN_karr72flags',
        );
    } 'a [Bool] default does not kill class generation';
    my $info = $flag_class->_k8s_attr_info;
    is_deeply($info->{flags}{options}{default}, [ 1, 0 ],
        'the recorded default is normalized to plain 0/1 per element');
};

done_testing;
