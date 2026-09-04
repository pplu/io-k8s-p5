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

# k94 review (Important 2): a codepoint above ASCII interpolated raw into
# 'qr/.../ ' or a quoted literal only round-trips through the emitted .pm
# file under conditions this emitter does not control (the file saved as
# UTF-8 bytes AND compiled under 'use utf8') -- \x{HEX} escapes make a
# pattern/enum/default correct independent of that. A schema's free-form
# 'description' is the one place non-ASCII text still lands in the file
# unescaped (verbatim, in POD, by design), and it is the only thing that
# should trigger 'use utf8' + '=encoding UTF-8' in the rendered source.
# t/data/crd-utf8.yaml is loaded from a real file (through
# IO::K8s::CRD->load's ':encoding(UTF-8)' read), not built as a Perl
# literal in this test, so its strings carry the UTF8 flag the same way a
# real CRD manifest's do -- the bug this guards against (Perl's \w matching
# a Unicode letter like 'µ' only when that flag is set) would not
# reproduce against an unflagged literal.
subtest 'non-ASCII patterns, enum values and descriptions render UTF-8-safely' => sub {
    my ($u_crd) = @{ IO::K8s::CRD->load("$FindBin::Bin/data/crd-utf8.yaml") };
    my $u_classes = IO::K8s::CRD->generate($u_crd, 'IO::K8s::_AUTOGEN_utf8emit');
    my $u_root = $u_classes->{'utf8.example.com/v1'};
    my $u_emitter = IO::K8s::CRD::Emitter->new(base => 'TestUtf8::V1');
    my $u_files = $u_emitter->render($u_root);

    is_deeply([ sort keys %$u_files ], [
        'TestUtf8/V1/Utf8Thing.pm',
        'TestUtf8/V1/Utf8ThingSpec.pm',
        'TestUtf8/V1/Utf8ThingSpecExtra.pm',
    ], 'one file per class');

    for my $path (sort keys %$u_files) {
        ok(eval "$u_files->{$path}\n1;", "compiles: $path") or diag "$path:\n" . $u_files->{$path} . "\n$@";
    }

    my $spec_src = $u_files->{'TestUtf8/V1/Utf8ThingSpec.pm'};
    like($spec_src, qr/^k8s interval\s+=> Str, \{ pattern => qr\/\^\[0-9\]\+\\x\{b5\}s\$\/ \};$/m,
        'the µ in the pattern renders as \x{HEX}, not a raw byte');
    like($spec_src, qr/^k8s mode\s+=> Str, \{ enum => \['safe',"\\x\{b5\}s"\] \};$/m,
        'the µ-only enum member switches to a double-quoted \x{HEX} literal; its ASCII sibling keeps single quotes');
    unlike($spec_src, qr/^use utf8;$/m, 'no description anywhere in this class -- the pattern/enum are already ASCII-safe -- so no use utf8');
    unlike($spec_src, qr/^=encoding/m, '...and no =encoding either');

    my $extra_src = $u_files->{'TestUtf8/V1/Utf8ThingSpecExtra.pm'};
    like($extra_src, qr/^use utf8;$/m, "the ü in this class's field description triggers use utf8");
    like($extra_src, qr/^our \$VERSION = '1\.108';\nuse utf8;$/m, 'use utf8 lands right after the VERSION line');
    like($extra_src, qr/^=encoding UTF-8$/m, '...and =encoding UTF-8');
    like($extra_src, qr/^=attr note\n\nNote with a \x{fc} character in its description\.\n/m,
        'the description keeps its real ü character, verbatim, not escaped');

    my $hand = IO::K8s->new; $hand->add({ Utf8Thing => '+TestUtf8::V1::Utf8Thing' });
    my $gen  = IO::K8s->new; $gen->add({ Utf8Thing => "+$u_root" });
    for my $value ("100\x{b5}s", '100ms', 'bogus') {
        my $doc = { apiVersion => 'utf8.example.com/v1', kind => 'Utf8Thing', metadata => { name => 'u' }, spec => { interval => $value } };
        my $hand_lived = eval { $hand->inflate($doc); 1 };
        my $gen_lived  = eval { $gen->inflate($doc); 1 };
        is(!!$hand_lived, !!$gen_lived, "interval matching '$value': emitted and generated classes agree");
    }
    for my $value ('safe', "\x{b5}s", 'bogus') {
        my $doc = { apiVersion => 'utf8.example.com/v1', kind => 'Utf8Thing', metadata => { name => 'u' }, spec => { mode => $value } };
        my $hand_lived = eval { $hand->inflate($doc); 1 };
        my $gen_lived  = eval { $gen->inflate($doc); 1 };
        is(!!$hand_lived, !!$gen_lived, "mode '$value': emitted and generated classes agree");
    }
};

# k94/long names: cert-manager's CRDs inline a full PodTemplateSpec several
# levels into a Challenge/ClusterIssuer 'spec', and the path-derived name
# for the deepest levels ran past Perl's 251-character identifier limit
# inside AutoGen's own (namespace-prefixed) class names. This emitter's own
# `base` is normally much shorter than that namespace prefix, so its joined
# package name usually still fits within 200 characters even when AutoGen's
# own name did not (see t/72's subtest for that case) -- this schema is
# deep enough that even the emitter's own joined name runs past 200,
# exercising its <Kind>_<hash> fallback too.
subtest 'a path-derived name past 200 chars still renders, with its own fallback and a names override' => sub {
    IO::K8s::AutoGen::clear_cache();

    my @keys = map {
        my $base = "level$_";
        $base . ('x' x (30 - length($base)));
    } 1 .. 8;

    my $leaf = { type => 'object', properties => { value => { type => 'string' } } };
    my $eight_deep = $leaf;
    $eight_deep = { type => 'object', properties => { $_ => $eight_deep } } for reverse @keys;

    my $schema = {
        type => 'object',
        'x-kubernetes-group-version-kind' => [ { group => 'deep.example.com', version => 'v1', kind => 'Deep' } ],
        properties => {
            apiVersion => { type => 'string' },
            kind       => { type => 'string' },
            metadata   => { type => 'object' },
            spec => { type => 'object', properties => { branch => $eight_deep } },
        },
    };

    my $deep_root = IO::K8s::AutoGen::get_or_generate('com.example.deep.v1.Deep', $schema, {}, 'IO::K8s::_AUTOGEN_karr_deepemit',
        api_version => 'deep.example.com/v1', kind => 'Deep', resource_plural => 'deeps', is_namespaced => 1);

    my $deepest = $deep_root->_k8s_attr_info->{spec}{class}->_k8s_attr_info->{branch}{class};
    $deepest = $deepest->_k8s_attr_info->{$_}{class} for @keys;
    like($deepest, qr/::_[0-9a-f]{10}$/, 'AutoGen itself had to shorten the deepest class');

    my $emitter = IO::K8s::CRD::Emitter->new(base => 'TestDeepEmit::V1');
    my $deep_files = $emitter->render($deep_root);
    for my $path (sort keys %$deep_files) {
        ok(eval "$deep_files->{$path}\n1;", "compiles: $path") or diag "$path:\n" . $deep_files->{$path} . "\n$@";
    }

    my $deepest_package = $emitter->package_for($deepest);
    like($deepest_package, qr/^TestDeepEmit::V1::Deep_[0-9a-f]{10}$/,
        "the emitter's own joined name also runs past 200 chars, so it falls back to <Kind>_<hash> too");

    my $doc = { value => 'leaf-value' };
    $doc = { $_ => $doc } for reverse @keys;
    my $full_doc = {
        apiVersion => 'deep.example.com/v1', kind => 'Deep',
        metadata   => { name => 'd' },
        spec       => { branch => $doc },
    };
    my $hand = IO::K8s->new; $hand->add({ Deep => '+TestDeepEmit::V1::Deep' });
    my $gen  = IO::K8s->new; $gen->add({ Deep => "+$deep_root" });
    is_deeply($hand->inflate($full_doc)->TO_JSON, $gen->inflate($full_doc)->TO_JSON,
        'the emitted (hash-fallback-named) class round-trips the same document as the generated one');

    # A names entry for the deepest class is honoured -- under a different
    # base, so its package names do not collide with the ones just eval'd.
    my $emitter2 = IO::K8s::CRD::Emitter->new(base => 'TestDeepNamed::V1', names => { $deepest => 'DeepLeaf' });
    my $named_files = $emitter2->render($deep_root);
    ok(exists $named_files->{'TestDeepNamed/V1/DeepLeaf.pm'}, 'a names entry for the deepest class is honoured');
    is($emitter2->package_for($deepest), 'TestDeepNamed::V1::DeepLeaf', 'package_for reflects the name map, not the fallback');
};

# k112: the registry already carries is_array_of_num/quantity/time/
# int_or_string (added for k96 task-2, read by IO::K8s::CRD's to_crd
# _type_schema), but this emitter's own _type_source -- the reverse,
# registry -> DSL-source direction -- still had no branch for any of the
# four and croaked. Unreachable today via any bundled provider or AutoGen
# schema path (AutoGen's array-item dispatch never produces one of these
# four flags from a schema; see the comment above IO::K8s::CRD::_type_schema),
# so reproduce with a hand-declared class exercising the DSL forms
# directly, the same way t/63_k66_array_of_hash.t does for [ {} ] / [ [] ].
{
    package Test::Karr112::Thing;
    use IO::K8s::Resource;
    k8s numbers    => [Num];
    k8s quantities => [Quantity];
    k8s times      => [Time];
    k8s flexes     => [IntOrStr];
}

subtest 'array-of-scalar Num/Quantity/Time/IntOrStr fields emit instead of croaking (k112)' => sub {
    my $emitter = IO::K8s::CRD::Emitter->new(base => 'TestKarr112::V1');
    my $files;
    lives_ok { $files = $emitter->render('Test::Karr112::Thing') }
        '_type_source no longer croaks on [Num]/[Quantity]/[Time]/[IntOrStr]';

    my $src = $files->{'TestKarr112/V1/Thing.pm'};
    like($src, qr/^k8s numbers\s+=> \[Num\];$/m,      'array of Num');
    like($src, qr/^k8s quantities\s+=> \[Quantity\];$/m, 'array of Quantity');
    like($src, qr/^k8s times\s+=> \[Time\];$/m,        'array of Time');
    like($src, qr/^k8s flexes\s+=> \[IntOrStr\];$/m,   'array of IntOrStr');

    ok(eval "$src\n1;", 'emitted source compiles') or diag $@;

    my $doc = {
        numbers    => [1, 2.5],
        quantities => ['100Mi', '2'],
        times      => ['2024-01-01T00:00:00Z'],
        flexes     => [1, '20%'],
    };
    my $hand    = Test::Karr112::Thing->new(%$doc);
    my $emitted = TestKarr112::V1::Thing->new(%$doc);
    is_deeply($emitted->TO_JSON, $hand->TO_JSON,
        'emitted class round-trips the same wire shape as the hand-written original');
};

done_testing;
