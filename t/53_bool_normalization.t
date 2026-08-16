#!/usr/bin/env perl
# karr #37: boolean normalization treated every reference as true, so the bare
# Perl false idiom \0 arrived as true.
#
# There are two places that normalize a boolean-ish input into the plain 0/1
# that gets stored on the attribute, and before this ticket they disagreed:
#
#   1. the Moo coercer in lib/IO/K8s/Resource.pm, which dereferences and was
#      therefore right about \0 and JSON::PP::Boolean, and
#   2. the is_bool branch of _inflate_struct in lib/IO/K8s.pm, which read
#      `... || $value ? 1 : 0` -- and in Perl *every* reference is true, so an
#      unblessed \0 came out as 1.
#
# _inflate_struct runs before $class->new(%args), so the wrong pre-normalization
# won: the coercer only ever saw a plain 1 and had nothing left to rescue.
# Everything downstream (accessor, TO_JSON, to_json) then reports a confident
# true, indistinguishable from a real one -- on fields like privileged,
# allowPrivilegeEscalation or hostNetwork.
#
# The same expression had a second defect in the same failure class, on a path
# the ticket did not mention: the string "false". `lc($value) eq 'true'` is
# false for it, so the `|| $value` fallback took over, and a non-empty string
# that is not "0" is true in Perl -- so "false" also became 1. That one was
# wrong in the coercer too, i.e. on *both* paths.
#
# This test pins the whole matrix on both entry points and, crucially, in both
# serialization directions: a test that only reads the accessor cannot fail when
# TO_JSON flips, and TO_JSON is what actually reaches the cluster.

use strict;
use warnings;
use Test::More;
use JSON::PP ();
use JSON::MaybeXS ();
use IO::K8s;
use IO::K8s::Api::Core::V1::SecurityContext ();
use IO::K8s::Api::Resource::V1::DeviceAttribute ();

my $k8s = IO::K8s->new;

# [ description, input value, expected plain 0/1 ]
my @cases = (
    [ 'JSON::PP::false'      => JSON::PP::false(),      0 ],
    [ 'JSON::PP::true'       => JSON::PP::true(),       1 ],
    [ 'JSON::MaybeXS::false' => JSON::MaybeXS::false(), 0 ],
    [ 'JSON::MaybeXS::true'  => JSON::MaybeXS::true(),  1 ],
    [ 'plain 0'              => 0,                      0 ],
    [ 'plain 1'              => 1,                      1 ],
    [ 'scalar ref \\0'       => \0,                     0 ],
    [ 'scalar ref \\1'       => \1,                     1 ],
    [ 'string "false"'       => 'false',                0 ],
    [ 'string "true"'        => 'true',                 1 ],
    [ 'string "False"'       => 'False',                0 ],
    [ 'string "0"'           => '0',                    0 ],
    [ 'string ""'            => '',                     0 ],
);

sub json_bool_name { $_[0] ? 'true' : 'false' }

subtest 'is_bool via struct_to_object (the _inflate_struct path)' => sub {
    for my $case (@cases) {
        my ($desc, $value, $want) = @$case;

        my $pod = $k8s->struct_to_object('Pod', {
            apiVersion => 'v1',
            kind       => 'Pod',
            metadata   => { name => 'p' },
            spec       => { containers => [
                { name => 'c', securityContext => { privileged => $value } },
            ] },
        });

        my $sc = $pod->spec->containers->[0]->securityContext;
        is($sc->privileged, $want, "$desc: accessor is $want");

        # Direction 2: what actually goes on the wire.
        my $out = $pod->TO_JSON->{spec}{containers}[0]{securityContext}{privileged};
        is(json_bool_name($out), json_bool_name($want),
            "$desc: TO_JSON emits " . json_bool_name($want));
        like($pod->to_json, qr/"privileged":\Q@{[ json_bool_name($want) ]}\E/,
            "$desc: encoded JSON carries " . json_bool_name($want));
    }
};

subtest 'is_bool via the constructor (the Moo coercer path)' => sub {
    for my $case (@cases) {
        my ($desc, $value, $want) = @$case;

        my $sc = IO::K8s::Api::Core::V1::SecurityContext->new(privileged => $value);
        is($sc->privileged, $want, "$desc: accessor is $want");
        is($sc->to_json, '{"privileged":' . json_bool_name($want) . '}',
            "$desc: serializes to " . json_bool_name($want));

        # FROM_HASH is the shallow entry point and hits the same coercer.
        my $from = IO::K8s::Api::Core::V1::SecurityContext->FROM_HASH({ privileged => $value });
        is($from->privileged, $want, "$desc: FROM_HASH accessor is $want");
    }
};

subtest 'is_bool via json_to_object (real decoded JSON booleans)' => sub {
    for my $literal (qw(true false)) {
        my $want = $literal eq 'true' ? 1 : 0;
        my $sc = $k8s->json_to_object(
            'IO::K8s::Api::Core::V1::SecurityContext',
            qq({"privileged":$literal}),
        );
        is($sc->privileged, $want, "JSON literal $literal: accessor is $want");
        is($sc->to_json, qq({"privileged":$literal}),
            "JSON literal $literal round-trips byte-identical");
    }
};

# is_array_of_bool has no branch in _inflate_struct at all -- the value falls
# through untouched and only the array coercer in Resource.pm sees it. So the
# \0 defect never applied here; this locks that in, and covers the string case
# which the array coercer shared with its scalar sibling.
subtest 'is_array_of_bool keeps every element distinct' => sub {
    my @in   = map { $_->[1] } @cases;
    my @want = map { $_->[2] } @cases;
    my $want_json = '{"bools":[' . join(',', map { json_bool_name($_) } @want) . ']}';

    my $via_struct = $k8s->struct_to_object('IO::K8s::Api::Resource::V1::DeviceAttribute', { bools => \@in });
    is_deeply($via_struct->bools, \@want, 'struct_to_object: every element normalized');
    is($via_struct->to_json, $want_json, 'struct_to_object: array serializes as JSON booleans');

    my $via_new = IO::K8s::Api::Resource::V1::DeviceAttribute->new(bools => \@in);
    is_deeply($via_new->bools, \@want, 'constructor: every element normalized');
    is($via_new->to_json, $want_json, 'constructor: array serializes as JSON booleans');
};

# The regression as reported, spelled out end to end: two Pods that differ only
# in how false was written must be byte-identical on the wire.
subtest 'karr #37: \\0 and JSON false produce identical output' => sub {
    my $make = sub {
        my ($v) = @_;
        return $k8s->struct_to_object('Pod', {
            apiVersion => 'v1',
            kind       => 'Pod',
            metadata   => { name => 'p' },
            spec       => { containers => [
                { name => 'c', securityContext => {
                    privileged               => $v,
                    allowPrivilegeEscalation => $v,
                } },
            ] },
        })->to_json;
    };

    my $expected = $make->(JSON::PP::false());
    like($expected, qr/"privileged":false/, 'JSON::PP::false stays false');
    is($make->(\0),      $expected, '\0 matches JSON::PP::false');
    is($make->('false'), $expected, 'string "false" matches JSON::PP::false');
    is($make->(0),       $expected, 'plain 0 matches JSON::PP::false');
};

done_testing;
