#!/usr/bin/env perl
# D5: a nested schema whose property set is exactly a shipped core class's
# key set is typed as that class instead of a nested AutoGen class.
use strict;
use warnings;
use Test::More;
use Test::Exception;

use IO::K8s;
use IO::K8s::AutoGen;

IO::K8s::AutoGen::clear_cache();

my $label_selector = {
    type => 'object',
    properties => {
        matchLabels      => { type => 'object', additionalProperties => { type => 'string' } },
        matchExpressions => {
            type  => 'array',
            items => {
                type => 'object',
                properties => {
                    key      => { type => 'string' },
                    operator => { type => 'string' },
                    values   => { type => 'array', items => { type => 'string' } },
                },
            },
        },
    },
};

my $schema = {
    type => 'object',
    'x-kubernetes-group-version-kind' => [ { group => 'reuse.example.com', version => 'v1', kind => 'Thing' } ],
    properties => {
        apiVersion => { type => 'string' }, kind => { type => 'string' }, metadata => { type => 'object' },
        spec => {
            type => 'object',
            properties => {
                selector    => $label_selector,
                requirement => {                      # {key,operator,values} alone: ambiguous
                    type => 'object',
                    properties => {
                        key      => { type => 'string' },
                        operator => { type => 'string' },
                        values   => { type => 'array', items => { type => 'string' } },
                    },
                },
                header => {                           # Core::V1::HTTPHeader: unique
                    type => 'object',
                    properties => { name => { type => 'string' }, value => { type => 'string' } },
                },
                partial => {                          # LabelSelector minus one field: not reused
                    type => 'object',
                    properties => { matchLabels => { type => 'object', additionalProperties => { type => 'string' } } },
                },
            },
        },
    },
};

my $class = IO::K8s::AutoGen::get_or_generate('com.example.reuse.v1.Thing', $schema, {}, 'IO::K8s::_AUTOGEN_reuse',
    api_version => 'reuse.example.com/v1', kind => 'Thing', resource_plural => 'things', is_namespaced => 1);
my $spec = $class->_k8s_attr_info->{spec}{class}->_k8s_attr_info;

subtest 'exact core shapes are referenced' => sub {
    is($spec->{selector}{class}, 'IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::LabelSelector', 'LabelSelector reused');
    is($spec->{header}{class}, 'IO::K8s::Api::Core::V1::HTTPHeader', 'unique shape reused');
    like($spec->{requirement}{class}, qr/^IO::K8s::_AUTOGEN_reuse::.*::Spec::Requirement$/, 'ambiguous shape stays a nested class');
    like($spec->{partial}{class}, qr/::Spec::Partial$/, 'a subset shape stays a nested class');
};

subtest 'parent context resolves the requirement inside a reused LabelSelector' => sub {
    my $k8s = IO::K8s->new;
    $k8s->add({ Thing => "+$class" });
    my $t = $k8s->inflate({ apiVersion => 'reuse.example.com/v1', kind => 'Thing', metadata => { name => 't' },
        spec => { selector => { matchExpressions => [ { key => 'k', operator => 'In', values => ['a'] } ] } } });
    isa_ok($t->spec->selector, 'IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::LabelSelector');
    isa_ok($t->spec->selector->matchExpressions->[0], 'IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::LabelSelectorRequirement');
    is_deeply($t->TO_JSON->{spec}{selector}{matchExpressions}[0], { key => 'k', operator => 'In', values => ['a'] }, 'round-trips');
};

subtest 'reuse_core => 0 keeps nested classes' => sub {
    IO::K8s::AutoGen::clear_cache();
    my $c = IO::K8s::AutoGen::get_or_generate('com.example.reuse.v1.Thing', $schema, {}, 'IO::K8s::_AUTOGEN_noreuse',
        api_version => 'reuse.example.com/v1', kind => 'Thing', resource_plural => 'things', is_namespaced => 1, reuse_core => 0);
    like($c->_k8s_attr_info->{spec}{class}->_k8s_attr_info->{selector}{class}, qr/::Spec::Selector$/, 'nested class');
};

subtest 'core_class_for_shape lists candidates in preference order' => sub {
    my @c = IO::K8s::AutoGen::core_class_for_shape([qw(key operator values)]);
    ok(@c > 1, 'several candidates');
    is($c[0], 'IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::LabelSelectorRequirement', 'Meta::V1 first');
};

done_testing;
