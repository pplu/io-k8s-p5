#!/usr/bin/env perl
# Upstream CRD spec drift checker for the IO::K8s CRD providers.
#
# The CRD analog of maint/spec-drift-check.pl. Where that tool diffs the
# core Kubernetes swagger.json against the shipped IO::K8s::Api::* classes,
# this one diffs each CRD provider's upstream CustomResourceDefinition
# manifests -- at the exact upstream_version the provider pins -- against
# what that provider actually ships: its resource_map (Kind coverage) and,
# where a class models its spec as a typed inline struct rather than an
# opaque hash, the class's k8s() attribute registry (field coverage).
#
# The six providers are IO::K8s::{Cilium,GatewayAPI,AgentSandbox,Traefik,
# CertManager,K3s}. Each one grew a `sub crd_sources` alongside its existing
# `sub upstream_version`: a data-only hook returning the upstream CRD-manifest
# URLs (base + files) for its pinned version, plus a `status`. A provider
# whose upstream publishes no machine-readable openAPIV3Schema (K3s) returns
# status => 'unresolved' and is reported as such rather than diffed.
#
# This is a report generator. It never writes to lib/, never touches the
# karr board, and never modifies the exceptions file -- deciding what a
# reported gap is worth is a human/agent call, not the script's.
#
# Usage:
#   maint/crd-drift-check.pl [--provider NAME]... [options]
#   maint/crd-drift-check.pl --provider Cilium --dir path/to/crd/yamls
#
# Examples:
#   maint/crd-drift-check.pl
#     Drift report for all six providers (cached CRDs under spec/crd/).
#
#   maint/crd-drift-check.pl --provider GatewayAPI --verbose
#     One provider, including entries suppressed by the exceptions file.
#
# Network access: fetches each provider's CRD manifests over HTTPS via
# HTTP::Tiny (raw.githubusercontent.com and GitHub release assets), the
# same discipline as spec-drift-check.pl. Downloaded manifests are cached
# under --cache-dir (default: spec/crd/<Provider>/<upstream_version>/, already
# gitignored) so repeat runs against the same pin don't re-fetch. The cache is
# keyed on the provider's upstream_version, so bumping a pin re-fetches
# automatically; --no-cache forces a re-download regardless.
use strict;
use warnings;
use v5.10;
use FindBin;
use File::Spec;
use File::Path qw(make_path);
use Getopt::Long qw(GetOptions);
use JSON::PP;

# File::Spec->rel2abs makes a path absolute but, on Unix, never collapses a
# '..' segment already in it (that's deliberate upstream: collapsing one
# blindly can change what a path means across a symlink). $DIST_ROOT itself
# is built from FindBin::Bin + '..', so left at rel2abs alone it would read
# as ".../maint/.." forever -- harmless for open()/-d, which the OS resolves
# fine, but fatal for the --suggest-dir "not inside lib/" guard below, which
# is a plain string-prefix test: a literal '..' anywhere in either side
# defeats it silently instead of refusing. _canon_abs collapses '.'/'..'
# lexically after rel2abs, with no filesystem lookup -- unlike Cwd::abs_path,
# it works on a --suggest-dir that doesn't exist yet.
sub _canon_abs {
    my ($path) = @_;
    my ($vol, $dirs) = File::Spec->splitpath(File::Spec->rel2abs($path), 1);
    my @out;
    for my $seg (File::Spec->splitdir($dirs)) {
        next if $seg eq '' || $seg eq '.';
        if ($seg eq '..') { pop @out if @out; next; }
        push @out, $seg;
    }
    return File::Spec->catdir($vol, File::Spec->rootdir, @out);
}

my $DIST_ROOT = _canon_abs(File::Spec->catdir($FindBin::Bin, '..'));
my $UA_STRING = 'io-k8s-p5-crd-drift-check (+https://github.com/pplu/io-k8s-p5)';

# The provider modules this tool knows how to check, in report order. Each
# is a Moo class composing IO::K8s::Role::ResourceMap with an upstream_version
# and (as of k82) a crd_sources method.
my @ALL_PROVIDERS = qw(Cilium GatewayAPI AgentSandbox Traefik CertManager K3s);

# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

sub usage {
    my ($exit_code) = @_;
    print <<"USAGE";
Usage:
  $0 [--provider NAME]... [options]

Options:
  --provider NAME     Provider to check (repeatable). One of:
                        @ALL_PROVIDERS
                       Default: all of them.
  --dir PATH          Local directory of CRD YAML manifests to diff instead
                       of fetching (implies a single --provider).
  --spec PATH         Alias for --dir.
  --exceptions PATH   Exceptions file (default: maint/crd-drift-exceptions.yaml)
  --lib PATH          lib/ directory to load providers from (default: DIST/lib)
  --cache-dir PATH    Downloaded-manifest cache root (default: DIST/spec/crd)
  --no-cache          Force re-download even if a cached copy exists
  --verbose           Also list items suppressed by the exceptions file
  --format text|json  Report format (default: text)
  --output PATH       Also write the report to this file
  --suggest           After the report, print the class source the emitter
                       renders for every OPAQUE SPEC and MISSING FIELD Kind
                       (never touches lib/).
  --suggest-dir PATH  Write those files under PATH instead of printing
                       (PATH must not be inside the distribution's lib/).
  --names FILE        YAML map of generated-class path (relative to the
                       Kind, e.g. "Middleware::Spec::RateLimit") to the
                       package name to use (e.g. "RateLimit") -- the
                       upstream Go type names (D6).
  --help              This message

For each provider, fetches its upstream CustomResourceDefinition manifests at
the pinned upstream_version, parses each openAPIV3Schema, and reports missing
Kinds, missing/extra top-level spec fields, opaque specs (spec not modeled
field-by-field), and stale/perl-only GVKs (shipped with no upstream CRD).

This is a report only -- it never creates karr tickets or edits lib/.
USAGE
    exit($exit_code // 0);
}

sub parse_args {
    my %opt = (
        exceptions  => File::Spec->catfile($FindBin::Bin, 'crd-drift-exceptions.yaml'),
        lib         => File::Spec->catdir($DIST_ROOT, 'lib'),
        'cache-dir' => File::Spec->catdir($DIST_ROOT, 'spec', 'crd'),
        format      => 'text',
        provider    => [],
    );
    GetOptions(\%opt,
        'provider=s@', 'dir=s', 'spec=s',
        'exceptions=s', 'lib=s', 'cache-dir=s', 'no-cache',
        'verbose', 'output=s', 'format=s', 'help|h',
        'suggest' => \$opt{suggest}, 'suggest-dir=s' => \$opt{suggest_dir}, 'names=s' => \$opt{names},
    ) or usage(1);
    usage(0) if $opt{help};
    if ($opt{format} !~ /^(text|json)$/) {
        die "crd-drift-check: --format must be 'text' or 'json'\n";
    }
    $opt{dir} //= $opt{spec};
    my @providers = @{ $opt{provider} };
    @providers = @ALL_PROVIDERS unless @providers;
    my %known = map { $_ => 1 } @ALL_PROVIDERS;
    for my $p (@providers) {
        die "crd-drift-check: unknown provider '$p' (known: @ALL_PROVIDERS)\n"
            unless $known{$p};
    }
    if (defined $opt{dir} && @providers != 1) {
        die "crd-drift-check: --dir/--spec requires exactly one --provider\n";
    }
    if ($opt{suggest_dir}) {
        $opt{suggest_dir} = _canon_abs($opt{suggest_dir});
        my $lib_abs = _canon_abs($opt{lib});
        die "crd-drift-check: --suggest-dir must not point inside lib/\n"
            if $opt{suggest_dir} eq $lib_abs || index($opt{suggest_dir}, "$lib_abs/") == 0;
    }
    $opt{provider} = \@providers;
    return \%opt;
}

# ---------------------------------------------------------------------------
# Provider + registry loading (mirrors spec-drift-check.pl's lib loading)
# ---------------------------------------------------------------------------

sub load_lib {
    my ($lib_dir) = @_;
    die "crd-drift-check: lib dir not found: $lib_dir\n" unless -d $lib_dir;
    unshift @INC, $lib_dir unless grep { $_ eq $lib_dir } @INC;
    require IO::K8s;
    return;
}

# A resource_map value -> fully-qualified Perl class. Mirrors
# IO::K8s::Role::ResourceMap's rule: a '+' prefix is used verbatim, anything
# else is relative to IO::K8s::.
sub qualify_class {
    my ($path) = @_;
    return substr($path, 1) if $path =~ /^\+/;
    return "IO::K8s::$path";
}

# ---------------------------------------------------------------------------
# CRD manifest fetch + cache
# ---------------------------------------------------------------------------

sub http_get {
    my ($url) = @_;
    require HTTP::Tiny;
    my $ua  = HTTP::Tiny->new(agent => $UA_STRING, timeout => 90);
    my $res = $ua->get($url);
    die sprintf("crd-drift-check: GET %s failed: %s %s\n",
        $url, $res->{status} // '?', $res->{reason} // '?')
        unless $res->{success};
    return $res->{content};
}

sub _slurp {
    my ($path) = @_;
    open my $fh, '<:encoding(UTF-8)', $path
        or die "crd-drift-check: cannot read $path: $!\n";
    local $/;
    my $content = <$fh>;
    close $fh;
    return $content;
}

# A `files` entry ('v2/foo.yaml') maps to one cache file with path
# separators flattened to '_' ('v2_foo.yaml'). Nothing here is committed:
# the cache is per-version local scratch under spec/crd/<Provider>/<version>/
# (fully gitignored), keyed on the provider's upstream_version so a pin bump
# re-fetches automatically.
sub cache_name_for {
    my ($file) = @_;
    (my $name = $file) =~ s{/}{_}g;
    return $name;
}

# Returns a list of [source_label, yaml_text] for a provider, either from a
# local --dir or from crd_sources (fetching + caching as needed).
sub load_manifests {
    my ($opt, $provider, $sources, $version) = @_;
    my @out;
    if (defined $opt->{dir}) {
        opendir my $dh, $opt->{dir}
            or die "crd-drift-check: cannot open --dir $opt->{dir}: $!\n";
        my @files = sort grep { /\.ya?ml$/ } readdir $dh;
        closedir $dh;
        die "crd-drift-check: no *.yaml manifests in $opt->{dir}\n" unless @files;
        for my $f (@files) {
            my $path = File::Spec->catfile($opt->{dir}, $f);
            push @out, [$f, _slurp($path)];
        }
        return @out;
    }

    # Cache is keyed on upstream_version so a pin bump caches separately and a
    # stale older-version cache never serves the wrong manifests.
    (my $safe_version = defined $version ? $version : '(unknown)')
        =~ s/[^A-Za-z0-9._-]/_/g;
    my $cache_dir = File::Spec->catdir($opt->{'cache-dir'}, $provider, $safe_version);
    make_path($cache_dir) unless -d $cache_dir;
    for my $file (@{ $sources->{files} }) {
        my $cache_file = File::Spec->catfile($cache_dir, cache_name_for($file));
        if (!$opt->{'no-cache'} && -f $cache_file) {
            push @out, [$file, _slurp($cache_file)];
            next;
        }
        my $url = $sources->{base} . '/' . $file;
        print STDERR "crd-drift-check: downloading $url ...\n";
        my $content = http_get($url);
        open my $fh, '>:encoding(UTF-8)', $cache_file
            or die "crd-drift-check: cannot write $cache_file: $!\n";
        print $fh $content;
        close $fh;
        push @out, [$file, $content];
    }
    return @out;
}

# ---------------------------------------------------------------------------
# CRD manifest parsing
#
# From each CustomResourceDefinition document: spec.group, spec.names.kind,
# and per served version its name + the spec-object property set from
# openAPIV3Schema.properties.spec.properties. GVK = "group/version/Kind".
# The whole document rides along too (doc), so --suggest can hand a
# reported GVK's manifest straight to IO::K8s::CRD->generate without
# re-fetching or re-parsing it.
# ---------------------------------------------------------------------------

sub parse_crds {
    my (@manifests) = @_;
    require YAML::PP;
    my $yp = YAML::PP->new(boolean => 'JSON::PP');
    my %by_gvk;    # "group/version/Kind" -> { kind, group, version, doc, spec_props => {name=>1}, has_spec_schema }
    for my $m (@manifests) {
        my ($label, $text) = @$m;
        my @docs = eval { $yp->load_string($text) };
        if ($@) {
            warn "crd-drift-check: could not parse $label: $@";
            next;
        }
        for my $doc (@docs) {
            next unless ref $doc eq 'HASH';
            next unless ($doc->{kind} // '') eq 'CustomResourceDefinition';
            my $spec  = $doc->{spec} or next;
            my $group = $spec->{group} // next;
            my $kind  = $spec->{names}{kind} // next;
            for my $ver (@{ $spec->{versions} // [] }) {
                my $vname = $ver->{name} // next;
                my $gvk   = "$group/$vname/$kind";
                my $schema     = $ver->{schema}{openAPIV3Schema};
                my $spec_props = $schema->{properties}{spec}{properties};
                $by_gvk{$gvk} = {
                    kind            => $kind,
                    group           => $group,
                    version         => $vname,
                    label           => $label,
                    doc             => $doc,
                    has_spec_schema => ($spec_props ? 1 : 0),
                    spec_props      => { map { $_ => 1 } keys %{ $spec_props // {} } },
                };
            }
        }
    }
    return \%by_gvk;
}

# ---------------------------------------------------------------------------
# Shipped-provider view: GVK -> class, from resource_map values.
#
# A mapped class's api_version() ("group/version") joined to its kind() is
# the exact GVK IO::K8s::add() would register it under -- the authoritative
# "what does this provider serve" set, independent of which resource_map
# keys (short or domain-qualified) happen to point at it.
# ---------------------------------------------------------------------------

sub shipped_view {
    my ($provider) = @_;
    my $pkg = "IO::K8s::$provider";
    my $map = $pkg->resource_map;
    my %gvk_class;    # gvk -> class
    my %classes;      # class -> 1 (unique)
    $classes{ qualify_class($_) } = 1 for values %$map;
    for my $class (sort keys %classes) {
        eval { require_class($class); 1 }
            or do { warn "crd-drift-check: failed to load $class: $@"; next };
        my $av   = eval { $class->api_version };
        my $kind = eval { $class->kind };
        next unless defined $av && defined $kind;
        $gvk_class{"$av/$kind"} = $class;
    }
    return \%gvk_class;
}

sub require_class {
    my ($class) = @_;
    (my $rel = $class) =~ s{::}{/}g;
    $rel .= '.pm';
    require $rel;
    return;
}

# The shipped `spec` field set for a class, or undef when spec is modeled
# opaquely (a { Str => 1 } hash, a free-form object, or simply absent). Only
# an inline struct (is_inline_struct) exposes upstream-comparable field
# names -- read from the auto-generated inner struct class's registry entry,
# using each attribute's wire json_key.
sub shipped_spec_fields {
    my ($class) = @_;
    my $reg  = \%IO::K8s::Resource::_attr_registry;
    my $info = $reg->{$class}{spec} or return undef;
    return undef unless $info->{is_inline_struct};
    my $inner = $info->{class} or return undef;
    my $inner_attrs = $reg->{$inner} // {};
    my %fields;
    for my $aname (keys %$inner_attrs) {
        $fields{ $inner_attrs->{$aname}{json_key} // $aname } = 1;
    }
    return \%fields;
}

# ---------------------------------------------------------------------------
# Exceptions file
# ---------------------------------------------------------------------------

sub load_exceptions {
    my ($path) = @_;
    die "crd-drift-check: exceptions file not found: $path\n" unless -f $path;
    require YAML::PP;
    my ($data) = YAML::PP->new->load_string(_slurp($path));
    $data //= {};
    $data->{ignore_missing_kinds} //= [];
    $data->{ignore_stale_kinds}   //= [];
    $data->{ignore_missing_fields} //= [];
    $data->{ignore_extra_fields}   //= [];
    return $data;
}

# GVK-level exceptions match on provider + exact gvk (a bare `gvk` with no
# `provider` matches in any provider).
sub gvk_excepted {
    my ($provider, $gvk, $entries) = @_;
    for my $e (@$entries) {
        next unless ref $e eq 'HASH';
        next unless ($e->{gvk} // '') eq $gvk;
        next if defined $e->{provider} && $e->{provider} ne $provider;
        return (1, $e->{reason});
    }
    return (0, undef);
}

# Field-level exceptions match on provider + gvk + field.
sub field_excepted {
    my ($provider, $gvk, $field, $entries) = @_;
    for my $e (@$entries) {
        next unless ref $e eq 'HASH';
        next unless ($e->{gvk} // '') eq $gvk && ($e->{field} // '') eq $field;
        next if defined $e->{provider} && $e->{provider} ne $provider;
        return (1, $e->{reason});
    }
    return (0, undef);
}

# ---------------------------------------------------------------------------
# Per-provider drift
# ---------------------------------------------------------------------------

sub check_provider {
    my ($opt, $provider, $exceptions) = @_;
    my $pkg = "IO::K8s::$provider";
    require_class($pkg);
    my $version = eval { $pkg->upstream_version } // '(unknown)';
    my $sources = eval { $pkg->crd_sources };
    die "crd-drift-check: $pkg has no crd_sources method\n" unless ref $sources eq 'HASH';

    my $shipped = shipped_view($provider);
    my $result  = {
        provider      => $provider,
        upstream      => $version,
        status        => $sources->{status} // 'ok',
        shipped_gvks  => scalar keys %$shipped,
        missing_kind  => [],
        missing_field => [],
        extra_field   => [],
        opaque_spec   => [],
        stale_gvk     => [],
        suppressed    => [],
        note          => $sources->{note},
    };

    # Unresolved upstream source (K3s): report the shipped GVKs, diff nothing.
    if (($sources->{status} // 'ok') ne 'ok') {
        $result->{stale_gvk} = [ map { [$_, $shipped->{$_}] } sort keys %$shipped ];
        $result->{unresolved} = 1;
        $result->{crd_count}  = 0;
        return $result;
    }

    my @manifests = load_manifests($opt, $provider, $sources, $version);
    my $upstream  = parse_crds(@manifests);
    $result->{crd_count} = scalar keys %$upstream;

    # Tier 1: upstream GVK with no shipped class.
    for my $gvk (sort keys %$upstream) {
        next if $shipped->{$gvk};
        my ($ign, $reason) = gvk_excepted($provider, $gvk, $exceptions->{ignore_missing_kinds});
        if ($ign) {
            push @{ $result->{suppressed} }, ['ignore_missing_kinds', $gvk, $reason];
            next;
        }
        push @{ $result->{missing_kind} }, [$gvk, $upstream->{$gvk}{kind}];
    }

    # Info: shipped GVK with no upstream CRD (stale / perl-only).
    for my $gvk (sort keys %$shipped) {
        next if $upstream->{$gvk};
        my ($ign, $reason) = gvk_excepted($provider, $gvk, $exceptions->{ignore_stale_kinds});
        if ($ign) {
            push @{ $result->{suppressed} }, ['ignore_stale_kinds', $gvk, $reason];
            next;
        }
        push @{ $result->{stale_gvk} }, [$gvk, $shipped->{$gvk}];
    }

    # Field-level: GVKs present in both.
    for my $gvk (sort keys %$upstream) {
        my $class = $shipped->{$gvk} or next;
        my $u = $upstream->{$gvk};
        my $shipped_fields = shipped_spec_fields($class);

        if (!defined $shipped_fields) {
            # spec modeled opaquely: field coverage not individually verified.
            push @{ $result->{opaque_spec} },
                [$gvk, $class, scalar keys %{ $u->{spec_props} }, $u->{has_spec_schema}];
            next;
        }
        if (!$u->{has_spec_schema}) {
            # class models spec fields but upstream has no spec schema to diff.
            push @{ $result->{opaque_spec} }, [$gvk, $class, 0, 0];
            next;
        }

        for my $f (sort keys %{ $u->{spec_props} }) {
            next if $shipped_fields->{$f};
            my ($ign, $reason) = field_excepted($provider, $gvk, $f, $exceptions->{ignore_missing_fields});
            if ($ign) {
                push @{ $result->{suppressed} }, ['ignore_missing_fields', "$gvk.$f", $reason];
                next;
            }
            push @{ $result->{missing_field} }, [$gvk, $class, $f];
        }
        for my $f (sort keys %$shipped_fields) {
            next if $u->{spec_props}{$f};
            my ($ign, $reason) = field_excepted($provider, $gvk, $f, $exceptions->{ignore_extra_fields});
            if ($ign) {
                push @{ $result->{suppressed} }, ['ignore_extra_fields', "$gvk.$f", $reason];
                next;
            }
            push @{ $result->{extra_field} }, [$gvk, $class, $f];
        }
    }
    $result->{_upstream} = $upstream;
    return $result;
}

# ---------------------------------------------------------------------------
# Rendering
# ---------------------------------------------------------------------------

sub render_provider {
    my ($r, $verbose) = @_;
    my @out;
    push @out, sprintf('########## %s (upstream %s) ##########', $r->{provider}, $r->{upstream});

    if ($r->{unresolved}) {
        push @out, 'status: SOURCE UNRESOLVED -- no upstream openAPIV3Schema to diff';
        push @out, "note:   $r->{note}" if $r->{note};
        push @out, "lib:    $r->{shipped_gvks} shipped GVK(s), not verified against upstream:";
        push @out, "  $_->[0]  ->  $_->[1]" for @{ $r->{stale_gvk} };
        push @out, '';
        return @out;
    }

    push @out, sprintf('spec:   %d upstream GVK(s) across the fetched CRD manifests', $r->{crd_count});
    push @out, sprintf('lib:    %d shipped GVK(s) from the resource_map', $r->{shipped_gvks});
    push @out, '';
    push @out, '--- SUMMARY ---';
    push @out, sprintf('  Tier 1  MISSING KIND    %4d  upstream GVK, no shipped class', scalar @{ $r->{missing_kind} });
    push @out, sprintf('  Tier 3  MISSING FIELD   %4d  upstream spec field a modeled class lacks', scalar @{ $r->{missing_field} });
    push @out, sprintf('  Info    EXTRA FIELD     %4d  modeled class declares a spec field upstream lacks', scalar @{ $r->{extra_field} });
    push @out, sprintf('  Info    OPAQUE SPEC     %4d  GVK whose spec is not modeled field-by-field', scalar @{ $r->{opaque_spec} });
    push @out, sprintf('  Info    STALE/PERL-ONLY %4d  shipped GVK, no matching upstream CRD', scalar @{ $r->{stale_gvk} });
    my %supp;
    $supp{ $_->[0] }++ for @{ $r->{suppressed} };
    push @out, sprintf('  Suppressed by exceptions: %d (%s)%s',
        scalar @{ $r->{suppressed} },
        join(', ', map { "$_: $supp{$_}" } sort keys %supp) || 'none',
        (@{ $r->{suppressed} } && !$verbose) ? ' -- rerun with --verbose to list them' : '');
    push @out, '';

    push @out, '--- Tier 1: MISSING KIND (upstream GVK, no shipped class) ---';
    push @out, "  $_->[0]" for @{ $r->{missing_kind} };
    push @out, '  (none)' unless @{ $r->{missing_kind} };
    push @out, '';

    push @out, '--- Tier 3: MISSING FIELD (upstream spec.<field>, class lacks it) ---';
    push @out, "  $_->[0]  spec.$_->[2]  ($_->[1])" for @{ $r->{missing_field} };
    push @out, '  (none)' unless @{ $r->{missing_field} };
    push @out, '';

    push @out, '--- Info: EXTRA FIELD (class has spec.<field>, upstream lacks it) ---';
    push @out, "  $_->[0]  spec.$_->[2]  ($_->[1])" for @{ $r->{extra_field} };
    push @out, '  (none)' unless @{ $r->{extra_field} };
    push @out, '';

    push @out, '--- Info: OPAQUE SPEC (spec not modeled field-by-field) ---';
    for my $e (@{ $r->{opaque_spec} }) {
        my ($gvk, $class, $n, $has_schema) = @$e;
        my $detail = $has_schema
            ? "upstream schema has $n spec field(s), class models spec opaquely"
            : 'upstream has no spec schema (preserve-unknown-fields)';
        push @out, "  $gvk  ($class): $detail";
    }
    push @out, '  (none)' unless @{ $r->{opaque_spec} };
    push @out, '';

    push @out, '--- Info: STALE / PERL-ONLY (shipped GVK, no upstream CRD) ---';
    push @out, "  $_->[0]  ->  $_->[1]" for @{ $r->{stale_gvk} };
    push @out, '  (none)' unless @{ $r->{stale_gvk} };

    if ($verbose && @{ $r->{suppressed} }) {
        push @out, '';
        push @out, '--- Suppressed by exceptions (--verbose) ---';
        for my $s (@{ $r->{suppressed} }) {
            my ($cat, $subject, $reason) = @$s;
            push @out, sprintf('  [%s] %s%s', $cat, $subject,
                (defined $reason ? "  -- $reason" : ''));
        }
    }
    push @out, '';
    return @out;
}

sub render_report {
    my ($results, $verbose) = @_;
    my @out;
    push @out, '=== IO::K8s crd-drift-check ===';
    push @out, 'providers: ' . join(', ', map { $_->{provider} } @$results);
    push @out, '';
    push @out, render_provider($_, $verbose) for @$results;
    return join("\n", @out) . "\n";
}

# ---------------------------------------------------------------------------
# --suggest: the classes the emitter would write for a reported Kind.
#
# Report-only stays report-only: the source goes to stdout or to a directory
# the caller names, never into lib/. One throwaway AutoGen namespace per
# GVK keeps the generated classes apart from anything the providers loaded.
# ---------------------------------------------------------------------------

sub load_names {
    my ($path) = @_;
    return {} unless $path;
    require YAML::PP;
    my $map = YAML::PP->new->load_file($path);
    die "crd-drift-check: --names file must be a YAML map\n" unless ref $map eq 'HASH';
    return $map;
}

sub suggest_for {
    my ($opt, $result, $upstream, $names) = @_;
    require IO::K8s::CRD;
    require IO::K8s::CRD::Emitter;
    my @gvks = map { $_->[0] } @{ $result->{opaque_spec} }, @{ $result->{missing_field} };
    my %seen;
    my %files;
    my $n = 0;
    for my $gvk (grep { !$seen{$_}++ } @gvks) {
        my $u = $upstream->{$gvk} or next;
        my $ns = 'IO::K8s::_SUGGEST_' . ++$n;
        my $classes = IO::K8s::CRD->generate($u->{doc}, $ns);
        my $root = $classes->{"$u->{group}/$u->{version}"} or next;
        # A --names key is written relative to the Kind (the Kind's own
        # generated class IS $root, e.g. '...::Middleware'), so a key of
        # 'Middleware::Spec::RateLimit' names the nested class
        # '$root::Spec::RateLimit' -- the leading 'Middleware::' names the
        # Kind, it is not repeated inside $root. Strip it before joining.
        my %class_names;
        for my $key (grep { $_ ne $u->{kind} } keys %$names) {
            (my $suffix = $key) =~ s/^\Q$u->{kind}\E:://;
            $class_names{"$root\::$suffix"} = $names->{$key};
        }
        my $emitter = IO::K8s::CRD::Emitter->new(
            base  => "IO::K8s::$result->{provider}::" . ucfirst($u->{version}),
            names => \%class_names,
        );
        my $rendered = $emitter->render($root);
        $files{$_} = $rendered->{$_} for keys %$rendered;
    }
    return \%files;
}

sub emit_suggestions {
    my ($opt, $files) = @_;
    return unless %$files;
    if ($opt->{suggest_dir}) {
        require File::Path;
        require File::Basename;
        for my $rel (sort keys %$files) {
            my $path = "$opt->{suggest_dir}/$rel";
            File::Path::make_path(File::Basename::dirname($path));
            open my $fh, '>:encoding(UTF-8)', $path or die "crd-drift-check: cannot write $path: $!\n";
            print $fh $files->{$rel};
            close $fh;
        }
        print "\n--- suggest: wrote " . scalar(keys %$files) . " file(s) under $opt->{suggest_dir}\n";
        return;
    }
    for my $rel (sort keys %$files) {
        print "\n#### $rel\n", $files->{$rel};
    }
}

# ---------------------------------------------------------------------------
# main
# ---------------------------------------------------------------------------

my $opt = parse_args();
load_lib($opt->{lib});
my $exceptions = load_exceptions($opt->{exceptions});

my @results = map { check_provider($opt, $_, $exceptions) } @{ $opt->{provider} };

my $report;
if ($opt->{format} eq 'json') {
    delete $_->{_upstream} for @results;
    $report = JSON::PP->new->canonical->pretty->encode({ providers => \@results });
} else {
    $report = render_report(\@results, $opt->{verbose});
}

print $report;
if ($opt->{output}) {
    open my $fh, '>:encoding(UTF-8)', $opt->{output}
        or die "crd-drift-check: cannot write $opt->{output}: $!\n";
    print $fh $report;
    close $fh;
}

if ($opt->{suggest} || $opt->{suggest_dir}) {
    my $names = load_names($opt->{names});
    my %files;
    for my $r (@results) {
        next unless $r->{_upstream};
        my $f = suggest_for($opt, $r, $r->{_upstream}, $names);
        $files{$_} = $f->{$_} for keys %$f;
    }
    emit_suggestions($opt, \%files);
}
