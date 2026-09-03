#!/usr/bin/env perl
# D10: the emitter renders a generated class set as house-style Perl source
# from the registry. The rendered source must compile into working classes
# that round-trip the same document as the generated originals.
use strict;
use warnings;
use Test::More;
use Test::Exception;
use FindBin;

use IO::K8s;
use IO::K8s::AutoGen;
use IO::K8s::CRD;
use IO::K8s::CRD::Emitter;

my ($crd) = @{ IO::K8s::CRD->load("$FindBin::Bin/data/crd-knob.yaml") };
my $classes = IO::K8s::CRD->generate($crd, 'IO::K8s::_AUTOGEN_emit');
my $root = $classes->{'opts.example.com/v1'};

my $emitter = IO::K8s::CRD::Emitter->new(
    base  => 'TestEmit::V1',
    names => { "$root\::Spec::Limit" => 'RateLimit' },
);
my $files = $emitter->render($root);

subtest 'one file per class, named from the base and the name map' => sub {
    is_deeply([ sort keys %$files ], [
        'TestEmit/V1/Knob.pm',
        'TestEmit/V1/KnobSpec.pm',
        'TestEmit/V1/KnobSpecRoutesItem.pm',
        'TestEmit/V1/KnobStatus.pm',
        'TestEmit/V1/RateLimit.pm',
    ], 'root, nested, and the renamed class');
    is($emitter->package_for("$root\::Spec::Limit"), 'TestEmit::V1::RateLimit', 'name map wins');
    is($emitter->package_for("$root\::Spec"), 'TestEmit::V1::KnobSpec', 'default: base + path joined');
};

subtest 'the root file is a house-style APIObject class' => sub {
    my $src = $files->{'TestEmit/V1/Knob.pm'};
    like($src, qr/^package TestEmit::V1::Knob;\n# ABSTRACT: /m, 'package + ABSTRACT');
    like($src, qr/^our \$VERSION = '1\.108';$/m, 'version line');
    like($src, qr/^use IO::K8s::APIObject\n    api_version     => 'opts\.example\.com\/v1',\n    resource_plural => 'knobs';$/m, 'APIObject import');
    like($src, qr/^with 'IO::K8s::Role::Namespaced';$/m, 'Namespaced');
    like($src, qr/^k8s spec\s+=> '\+TestEmit::V1::KnobSpec', \{ required => 'schema' \};$/m, 'required object field, renamed, recorded not enforced');
    like($src, qr/^k8s status\s+=> '\+TestEmit::V1::KnobStatus';$/m, 'status');
    like($src, qr/^=attr spec\n/m, 'attr POD for spec');
    like($src, qr/\n1;\n\z/, 'ends with 1;');
    unlike($src, qr/_AUTOGEN/, 'no generated namespace leaks into the source');
};

subtest 'field lines render every type form and the options' => sub {
    my $src = $files->{'TestEmit/V1/KnobSpec.pm'};
    like($src, qr/^use IO::K8s::Resource;$/m, 'nested class is a Resource');
    like($src, qr/^k8s mode\s+=> Str, \{ required => 'schema', enum => \[qw\(fast safe\)\], default => 'safe' \};$/m, 'enum + default + schema-required');
    like($src, qr/^k8s replicas\s+=> Int, \{ minimum => 0, maximum => 5 \};$/m, 'range');
    like($src, qr/^k8s limit\s+=> '\+TestEmit::V1::RateLimit';$/m, 'nested object via the name map');
    like($src, qr/^k8s routes\s+=> \['\+TestEmit::V1::KnobSpecRoutesItem'\];$/m, 'array of objects');
    like($src, qr/^k8s size\s+=> IntOrStr;$/m, 'int-or-string');
    like($src, qr/^k8s extra\s+=> \{ Str => 1 \}, \{ preserve_unknown => 1 \};$/m, 'opaque map with a schema-only option');
    like($src, qr/^=attr mode\n\nOperating mode\.\n/m, 'description becomes the =attr text');
    like($src, qr/^=attr replicas\n\nNo description in the upstream schema\.\n/m, 'fallback text');
    unlike($src, qr/description =>/, 'description is not repeated as an option');
    my $limit = $files->{'TestEmit/V1/RateLimit.pm'};
    like($limit, qr/^package TestEmit::V1::RateLimit;\n# ABSTRACT: Rate limit applied to the knob\.$/m, 'ABSTRACT from the object description');
    like($limit, qr/^k8s period\s+=> Str, \{ pattern => qr\/\^\[0-9\]\+\[smh\]\$\/ \};$/m, 'pattern as qr//');
    my $item = $files->{'TestEmit/V1/KnobSpecRoutesItem.pm'};
    like($item, qr/^k8s match\s+=> Str, \{ required => 'schema' \};$/m, 'required alone still renders the schema form');
};

subtest 'the rendered source compiles and round-trips the same document' => sub {
    for my $path (sort keys %$files) {
        my $src = $files->{$path};
        ok(eval "$src\n1;", "compiles: $path") or diag $@;
    }
    my $k8s = IO::K8s->new;
    $k8s->add({ Knob => '+TestEmit::V1::Knob' });
    my $doc = {
        apiVersion => 'opts.example.com/v1', kind => 'Knob',
        metadata => { name => 'k', namespace => 'd' },
        spec => { mode => 'fast', replicas => 2, limit => { average => 1, period => '5s' },
                  routes => [ { match => 'a', weight => 1 } ], size => 3, extra => { x => 1 } },
        status => { ready => JSON::PP::true() },
    };
    require JSON::PP;
    my $hand = $k8s->inflate($doc);
    isa_ok($hand->spec->limit, 'TestEmit::V1::RateLimit');
    my $gen = do { my $g = IO::K8s->new; $g->add({ Knob => "+$root" }); $g->inflate($doc) };
    is_deeply($hand->TO_JSON, $gen->TO_JSON, 'emitted classes and generated classes agree on the wire');
    throws_ok { $k8s->inflate({ %$doc, spec => { mode => 'slow' } }) } qr/not one of: fast, safe/, 'constraints survive the round-trip into source';
};

subtest 'patterns needing escaping, an empty-string enum, and unfriendly descriptions render safely' => sub {
    my $schema = {
        type => 'object',
        # No trailing '.': the multi-line-with-no-sentence-end case that used
        # to leave a raw newline in the # ABSTRACT comment (uncompilable).
        description => "A resource for exercising the emitter's escaping\nlogic across several lines",
        'x-kubernetes-group-version-kind' => [ { group => 'esc.example.com', version => 'v1', kind => 'Escaper' } ],
        properties => {
            spec => {
                type => 'object',
                properties => {
                    email => {
                        type        => 'string',
                        pattern     => '^[a-z]+@example\.com$',
                        description => "Contact address.\n=head1 not a real POD command\n\n\n\nTrailing paragraph.",
                    },
                    path    => { type => 'string', pattern => '^\/api\/v1$' },
                    single  => { type => 'string', pattern => '^a$' },
                    alt     => { type => 'string', pattern => '^(a|b)$' },
                    atparen => { type => 'string', pattern => '(a@$)' },
                    atalt   => { type => 'string', pattern => '(a@$|b)' },
                    mode    => { type => 'string', enum => [ '', 'Always', 'IfNotPresent' ] },
                },
            },
        },
    };
    my $gen = IO::K8s::AutoGen::get_or_generate('com.example.esc.v1.Escaper', $schema, {}, 'IO::K8s::_AUTOGEN_esc',
        api_version => 'esc.example.com/v1', kind => 'Escaper', resource_plural => 'escapers', is_namespaced => 1);
    my $esc_files = IO::K8s::CRD::Emitter->new(base => 'TestEscape::V1')->render($gen);
    for my $path (sort keys %$esc_files) {
        ok(eval "$esc_files->{$path}\n1;", "compiles: $path") or diag "$path:\n" . $esc_files->{$path} . "\n$@";
    }

    like($esc_files->{'TestEscape/V1/Escaper.pm'},
        qr/^# ABSTRACT: A resource for exercising the emitter's escaping logic across several lines$/m,
        'a multi-line, period-less description collapses to one ABSTRACT line instead of interpolating raw');

    my $spec_src = $esc_files->{'TestEscape/V1/EscaperSpec.pm'};
    like($spec_src, qr/^k8s email\s+=> Str, \{ pattern => qr\/\^\[a-z\]\+\\\@example\\\.com\$\/ \};$/m,
        'an @ that would interpolate is escaped');
    like($spec_src, qr/^k8s path\s+=> Str, \{ pattern => qr\/\^\\\/api\\\/v1\$\/ \};$/m,
        'an already-escaped slash is not double-escaped');
    like($spec_src, qr/^k8s single\s+=> Str, \{ pattern => qr\/\^a\$\/ \};$/m,
        'a $ anchoring end-of-string is left alone');
    like($spec_src, qr/^k8s alt\s+=> Str, \{ pattern => qr\/\^\(a\|b\)\$\/ \};$/m,
        'a $ before the closing delimiter is left alone');
    like($spec_src, qr/^k8s atparen\s+=> Str, \{ pattern => qr\/\(a\\\@\$\)\/ \};$/m,
        'an @ immediately before a ) -anchored $ is still escaped, not just ones before \w or {');
    like($spec_src, qr/^k8s atalt\s+=> Str, \{ pattern => qr\/\(a\\\@\$\|b\)\/ \};$/m,
        'an @ immediately before a |-anchored $ is still escaped');
    like($spec_src, qr/^k8s mode\s+=> Str, \{ enum => \['',\s*'Always',\s*'IfNotPresent'\] \};$/m,
        'an enum containing the empty string renders as a Dumper list');
    unlike($spec_src, qr/qw\(/, 'no qw() form once one entry needs quoting');
    like($spec_src,
        qr/^=attr email\n\nContact address\.\nE<61>head1 not a real POD command\n\nTrailing paragraph\.\n/m,
        'a description line starting with = is escaped and a blank-line run collapses to one');

    my $hand = IO::K8s->new; $hand->add({ Escaper => '+TestEscape::V1::Escaper' });
    my $orig = IO::K8s->new; $orig->add({ Escaper => "+$gen" });
    my %cases = (
        email  => { ok => 'a@example.com', bad => 'not-an-email' },
        path   => { ok => '/api/v1',       bad => '/api/v2' },
        single => { ok => 'a',             bad => 'b' },
        alt    => { ok => 'a',             bad => 'c' },
        mode   => { ok => '',              bad => 'Sometimes' },
    );
    for my $field (sort keys %cases) {
        for my $which (qw( ok bad )) {
            my $value = $cases{$field}{$which};
            my $doc = {
                apiVersion => 'esc.example.com/v1', kind => 'Escaper',
                metadata => { name => 'e' }, spec => { $field => $value },
            };
            my $hand_lived = eval { $hand->inflate($doc); 1 };
            my $orig_lived = eval { $orig->inflate($doc); 1 };
            is(!!$hand_lived, !!$orig_lived, "$field/$which ('$value'): emitted and generated classes agree");
        }
    }

    # '(a@$)' and '(a@$|b)': the '@' sits directly before a '$' that is
    # itself in an anchor position (before ')' or '|'), which a narrower
    # "escape @ only before \w or {" rule left bare -- '@$)'/'@$|' then
    # interpolated away to nothing, so the emitted class silently accepted
    # values ('a', 'zzza') the generated class rejects. Same four values
    # against both fields: only 'a@' should be accepted by '(a@$)', 'a@'
    # and 'b' by '(a@$|b)' -- but the assertion is agreement, not a fixed
    # accept/reject table, so a regression shows up either way.
    for my $field (qw( atparen atalt )) {
        for my $value ('a@', 'a', 'zzza', 'b') {
            my $doc = {
                apiVersion => 'esc.example.com/v1', kind => 'Escaper',
                metadata => { name => 'e' }, spec => { $field => $value },
            };
            my $hand_lived = eval { $hand->inflate($doc); 1 };
            my $orig_lived = eval { $orig->inflate($doc); 1 };
            is(!!$hand_lived, !!$orig_lived, "$field ('$value'): emitted and generated classes agree");
        }
    }
};

done_testing;
