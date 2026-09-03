#!/usr/bin/env perl
# D4: IO::K8s::Unstructured -- apiVersion/kind/metadata as real k8s
# attributes, everything else preserved via the D1 _unknown_fields bag, for
# a Kind nothing else resolves. IO::K8s->new(unknown_kinds => 'unstructured')
# opts a caller into building one instead of dying; bare IO::K8s keeps
# failing closed with today's GVK error (D4, k96).
use strict;
use warnings;
use Test::More;
use Test::Exception;
use JSON::PP ();

use IO::K8s;
use IO::K8s::Unstructured;

# A hand-written CR for a Kind this distribution has never heard of, with
# nested unknown structure (arrays, hashes, booleans) buried in both spec
# and status -- nothing here is declared anywhere, so all of it has to
# survive purely through the D1 bag.
my $unknown_cr = {
    apiVersion => 'example.com/v1',
    kind       => 'Widget',
    metadata   => {
        name      => 'my-widget',
        namespace => 'default',
        labels    => { tier => 'test' },
    },
    spec => {
        color  => 'blue',
        size   => 42,
        nested => {
            list => [ 1, 2, 3 ],
            flag => JSON::PP::true,
            deep => { a => 'b' },
        },
    },
    status => {
        phase      => 'Ready',
        conditions => [ { type => 'Available', status => 'True' } ],
    },
};

subtest 'direct FROM_HASH round-trips a hand-written CR byte-identically' => sub {
    my $obj = IO::K8s::Unstructured->FROM_HASH($unknown_cr);

    isa_ok($obj, 'IO::K8s::Unstructured');
    is($obj->apiVersion, 'example.com/v1', 'apiVersion accessor');
    is($obj->kind, 'Widget', 'kind accessor');
    isa_ok($obj->metadata, 'IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta',
        'metadata is typed');
    is($obj->metadata->name, 'my-widget', 'metadata->name accessor');

    is_deeply($obj->TO_JSON, $unknown_cr, 'TO_JSON round-trips the whole document byte-identically');
};

subtest 'bare IO::K8s still dies on an unregistered Kind' => sub {
    my $k8s = IO::K8s->new;
    throws_ok { $k8s->inflate($unknown_cr) }
        qr/\ACannot resolve Kubernetes GVK: kind 'Widget', apiVersion 'example\.com\/v1'/,
        'the current fail-closed GVK error, unchanged';
};

subtest "unknown_kinds => 'unstructured' opts inflate() into building one" => sub {
    my $k8s = IO::K8s->new(unknown_kinds => 'unstructured');
    my $obj;
    lives_ok { $obj = $k8s->inflate($unknown_cr) }
        'inflate does not die when unknown_kinds is unstructured';

    isa_ok($obj, 'IO::K8s::Unstructured');
    is_deeply($obj->TO_JSON, $unknown_cr, 'the inflated object round-trips byte-identically');
};

subtest "an unrelated unknown_kinds value keeps failing closed" => sub {
    my $k8s = IO::K8s->new(unknown_kinds => 'something-else');
    throws_ok { $k8s->inflate($unknown_cr) }
        qr/\ACannot resolve Kubernetes GVK: kind 'Widget', apiVersion 'example\.com\/v1'/,
        'only the literal value "unstructured" opts in';
};

subtest "unknown_kinds => 'unstructured' also covers new_object" => sub {
    my $k8s = IO::K8s->new(unknown_kinds => 'unstructured');
    my $obj;
    lives_ok {
        $obj = $k8s->new_object('Widget', { metadata => { name => 'y' } }, 'example.com/v1');
    } 'new_object does not die when unknown_kinds is unstructured';

    isa_ok($obj, 'IO::K8s::Unstructured');
    is($obj->apiVersion, 'example.com/v1', 'apiVersion filled in from the GVK request');
    is($obj->kind, 'Widget', 'kind filled in from the short_class argument');
    is($obj->metadata->name, 'y', 'the rest of params carries through');
};

subtest 'a registered Kind is unaffected by unknown_kinds' => sub {
    my $k8s = IO::K8s->new(unknown_kinds => 'unstructured');
    my $pod = $k8s->inflate({
        apiVersion => 'v1', kind => 'Pod',
        metadata   => { name => 'x' },
        spec       => { containers => [] },
    });
    isa_ok($pod, 'IO::K8s::Api::Core::V1::Pod');
};

done_testing;
