#!/usr/bin/env perl
# D3: IO::K8s::AutoGen carries an OpenAPI property's required/enum/minimum/
# maximum/pattern/default/description/nullable/x-kubernetes-preserve-
# unknown-fields into the generated class's field options.
use strict;
use warnings;
use Test::More;
use Test::Exception;

use IO::K8s::AutoGen;

IO::K8s::AutoGen::clear_cache();

require JSON::PP;

# 'spec' is a $ref to a sibling definition, not inlined -- a bare
# `type: object` with its own `properties` and no `$ref`/`additionalProperties`
# is, by AutoGen's existing design, an opaque hash-of-strings (t/04_autogen.t
# and t/57_autogen_k55_60.t both read it back as a plain hashref,
# $obj->spec->{field}). The $ref shape below is what a real swagger v2 host
# actually produces for a nested type and is what _schema_to_type_spec's
# existing $ref path already turns into a typed nested class via
# get_or_generate -- exactly the class this test needs to inspect.
my $spec_def = {
    type => 'object',
    required => [ 'mode' ],
    properties => {
        mode     => { type => 'string', enum => [ 'fast', 'safe' ], description => 'operating mode', default => 'safe' },
        replicas => { type => 'integer', minimum => 0, maximum => 5, default => 1 },
        ratio    => { type => 'number', minimum => 0.1 },
        name     => { type => 'string', pattern => '^[a-z]+$' },
        tags     => { type => 'array', items => { type => 'string', enum => [ 'a', 'b' ] } },
        ports    => { type => 'array', items => { type => 'integer', maximum => 65535 } },
        weird    => { type => 'string', pattern => '[' },
        flag     => { type => 'boolean', default => JSON::PP::true() },
        extra    => { type => 'object', 'x-kubernetes-preserve-unknown-fields' => JSON::PP::true(), nullable => JSON::PP::true() },
        note     => { type => 'string', nullable => JSON::PP::true(), default => undef },
        flagged  => { type => 'string', nullable => 'false' },
    },
};

my $schema = {
    type => 'object',
    'x-kubernetes-group-version-kind' => [ { group => 'opts.example.com', version => 'v1', kind => 'Knob' } ],
    required => [ 'spec' ],
    properties => {
        apiVersion => { type => 'string' },
        kind       => { type => 'string' },
        metadata   => { '$ref' => '#/definitions/io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta' },
        spec       => { '$ref' => '#/definitions/com.example.opts.v1.KnobSpec' },
    },
};

my $all_defs = { 'com.example.opts.v1.KnobSpec' => $spec_def };

my $class;
lives_ok {
    $class = IO::K8s::AutoGen::get_or_generate('com.example.opts.v1.Knob', $schema, $all_defs, 'IO::K8s::_AUTOGEN_opts',
        api_version => 'opts.example.com/v1', kind => 'Knob', resource_plural => 'knobs', is_namespaced => 1);
} 'class generation lives with a null default (nullable field) and mixed nullable spellings';
my $spec_class = $class->_k8s_attr_info->{spec}{class};

subtest 'registry of the generated spec class' => sub {
    my $info = $spec_class->_k8s_attr_info;
    is($info->{mode}{required}, 1, 'required list -> required');
    is_deeply($info->{mode}{options}{enum}, [ 'fast', 'safe' ], 'enum');
    is($info->{mode}{options}{description}, 'operating mode', 'description');
    is($info->{mode}{options}{default}, 'safe', 'default');
    is($info->{replicas}{options}{minimum}, 0, 'minimum');
    is($info->{replicas}{options}{maximum}, 5, 'maximum');
    is($info->{ratio}{options}{minimum}, 0.1, 'Num minimum');
    is(ref $info->{name}{options}{pattern}, 'Regexp', 'pattern compiled');
    is_deeply($info->{tags}{options}{enum}, [ 'a', 'b' ], 'array items enum lifted to the field');
    is($info->{ports}{options}{maximum}, 65535, 'array items maximum lifted');
    ok(!exists $info->{weird}{options}{pattern}, 'an uncompilable pattern is dropped, the class still exists');
    ok($info->{flag}{options}{default}, 'boolean default kept');
    ok(!exists $info->{flag}{options}{enum}, 'no value constraints on Bool');
    is($info->{extra}{options}{preserve_unknown}, 1, 'x-kubernetes-preserve-unknown-fields');
    is($info->{extra}{options}{nullable}, 1, 'nullable');
    is($info->{note}{options}{nullable}, 1, 'note: nullable normalized from a JSON::PP::Boolean');
    ok(!exists $info->{note}{options}{default}, 'note: a null default is no default at all');
    ok(!exists $info->{flagged}{options}{nullable}, "flagged: the string 'false' is false, not truthy Perl");
    is($class->_k8s_attr_info->{spec}{required}, 1, 'top-level required list applies too');
};

subtest 'constraints are enforced on the generated class' => sub {
    lives_ok { $spec_class->new(mode => 'fast', replicas => 5, name => 'abc', tags => ['a'], ports => [80]) } 'valid values';
    throws_ok { $spec_class->new(mode => 'slow') } qr/Value "slow" is not one of: fast, safe/, 'enum';
    throws_ok { $spec_class->new(mode => 'fast', replicas => 6) } qr/above the maximum 5/, 'maximum';
    throws_ok { $spec_class->new(mode => 'fast', name => 'ABC') } qr/does not match the pattern/, 'pattern';
    throws_ok { $spec_class->new(mode => 'fast', tags => ['c']) } qr/is not one of: a, b/, 'array element enum';
    throws_ok { $spec_class->new(mode => 'fast', ports => [70000]) } qr/above the maximum 65535/, 'array element maximum';
    throws_ok { $spec_class->new() } qr/Missing required arguments: mode/, 'required';
    lives_ok { $spec_class->new(mode => 'fast', weird => 'anything[') } 'dropped pattern enforces nothing';
};

subtest 'inflate through IO::K8s honours the same constraints' => sub {
    require IO::K8s;
    my $k8s = IO::K8s->new(openapi_spec => { definitions => { %$all_defs, 'com.example.opts.v1.Knob' => $schema } });
    throws_ok {
        $k8s->inflate({ apiVersion => 'opts.example.com/v1', kind => 'Knob', metadata => { name => 'k' }, spec => { mode => 'slow' } });
    } qr/is not one of: fast, safe/, 'a document from the cluster with a bad enum value fails at inflate';
};

done_testing;
