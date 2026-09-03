package IO::K8s::CRD::Emitter;
# ABSTRACT: Render generated IO::K8s classes as house-style Perl source
our $VERSION = '1.108';
use v5.10;
use Moo;
use Carp qw( croak );
use Data::Dumper ();
use Digest::SHA qw( sha1_hex );
use re ();
use Types::Standard qw( Str HashRef );
use IO::K8s::AutoGen ();
use IO::K8s::Role::Resource ();

=head1 SYNOPSIS

    my $classes = IO::K8s::CRD->generate($crd, 'IO::K8s::_SUGGEST');
    my $emitter = IO::K8s::CRD::Emitter->new(
        base  => 'IO::K8s::Traefik::V1alpha1',
        names => { "$root\::Spec::RateLimit" => 'RateLimit' },   # D6: upstream Go type names
    );
    my $files = $emitter->render($classes->{'traefik.io/v1alpha1'});
    # { 'IO/K8s/Traefik/V1alpha1/Middleware.pm' => "package ...", ... }

=head1 DESCRIPTION

The source half of D10: what L<IO::K8s::CRD> generates at runtime, rendered
as the checked-in, hand-maintained class files this distribution ships --
one file per class, the C<k8s> DSL line per field with its options, the
schema description as the field's C<=attr> POD. It reads nothing but the
attribute registry of the generated classes, so it renders any AutoGen
class set, and it never writes a file: callers get C<< { path => source } >>
and decide (C<maint/crd-drift-check.pl --suggest> prints,
C<--suggest-dir> writes outside C<lib/>).

Descriptions go into POD, not into the C<description> field option: the
house format documents every field once, in the C<=attr> block.

=cut

=attr base

The package prefix of the rendered classes, e.g. C<IO::K8s::Traefik::V1alpha1>.
Required.

=attr names

Hashref from a generated class name to the bare package name it should get
under L</base>: C<< { 'IO::K8s::_AUTOGEN_x::...::Middleware::Spec::RateLimit' => 'RateLimit' } >>.
Classes not listed get their path joined: C<Middleware::Spec::RateLimit>
becomes C<MiddlewareSpecRateLimit>. This is where the upstream Go type
names (D6) come in.

=attr version

The C<$VERSION> line to write. Defaults to this distribution's.

=cut

has base    => (is => 'ro', isa => Str, required => 1);
has names   => (is => 'ro', isa => HashRef, default => sub { {} });
has version => (is => 'ro', isa => Str, default => sub { $VERSION });

# Reverse of IO::K8s::Resource's class-prefix map: a stock class is written
# the short way the hand-written classes use ('Core::V1::PodTemplateSpec').
my @SHORT_PREFIXES = (
    [ 'IO::K8s::Apimachinery::Pkg::Apis::Meta'                          => 'Meta' ],
    [ 'IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions'       => 'Apiextensions' ],
    [ 'IO::K8s::KubeAggregator::Pkg::Apis::Apiregistration'             => 'KubeAggregator' ],
    [ 'IO::K8s::Api'                                                    => '' ],
);

=method package_for

    my $package = $emitter->package_for($generated_class);

The package a generated class is rendered as: L</names> when listed,
otherwise L</base> plus the class's path segments below its Kind joined
together (the Kind itself for the root).

A class deep enough that L<IO::K8s::AutoGen> had to shorten its own
namespace-qualified Perl name (past its 251-character identifier limit --
see C<$MAX_CLASS_NAME> there) is rendered from C<< IO::K8s::AutoGen::class_path
>>, the field path AutoGen records regardless of shortening, not from the
class's own (possibly hashed) name -- this emitter's own C<base> is
normally much shorter than the AutoGen namespace prefix that forced the
shortening, so the joined package name here often fits fine even when
AutoGen's did not. Only when the joined name would itself run past
C<$MAX_PACKAGE_SUFFIX> characters, or C<base> is itself long enough that
the full package name would, does the emitted package fall back to
C<< <Kind>_<10 hex chars> >>, the hex digits a C<sha1_hex> of the field
path; give such a class a proper name via L</names> instead of relying on
that fallback.

=cut

# Bounds only the suffix this method appends below `base` -- AutoGen's own
# $MAX_CLASS_NAME bounds the full namespace-qualified name IT generates,
# which this has no control over and does not need to duplicate.
my $MAX_PACKAGE_SUFFIX = 200;

# A filesystem path component -- and much tooling that shells out to a file
# name -- tops out around 255 bytes. A long `base` plus an otherwise-short
# suffix can still cross that even when the suffix alone passes the check
# above, so the joined package name as a whole is capped too.
my $MAX_PACKAGE_LENGTH = 255;

sub package_for {
    my ($self, $class) = @_;
    my $root = $self->{_root} // croak 'package_for needs a render() first';
    return $self->base . '::' . $self->names->{$class} if $self->names->{$class};
    my $kind = (split /::/, $root)[-1];

    # The field path, independent of whatever (possibly hash-shortened)
    # Perl name AutoGen gave the class -- see the POD above.
    my $path = IO::K8s::AutoGen::class_path($class);
    unless (defined $path) {
        ($path = $class) =~ s/^\Q$root\E(?:::)?//;
    }

    my $joined = join '', $kind, split /::/, $path;
    my $full   = $self->base . '::' . $joined;
    if (length($joined) > $MAX_PACKAGE_SUFFIX || length($full) > $MAX_PACKAGE_LENGTH) {
        $joined = $kind . '_' . substr(sha1_hex($path), 0, 10);
        $full   = $self->base . '::' . $joined;
    }
    return $full;
}

=method render

    my $files = $emitter->render($root_class);

Renders C<$root_class> and every generated class reachable from its fields
(objects, arrays of objects, maps of objects) as
C<< { 'Relative/Path.pm' => $source } >>. Stock classes referenced by a
field (C<ObjectMeta>, core types) are written by their short name and not
rendered.

=cut

sub render {
    my ($self, $root) = @_;
    $self->{_root} = $root;   # kept after render() so package_for() stays usable
    my %files;
    my @todo = ($root);
    my %seen;
    while (my $class = shift @todo) {
        next if $seen{$class}++;
        my ($source, @nested) = $self->_render_class($class);
        (my $path = $self->package_for($class)) =~ s{::}{/}g;
        $files{"$path.pm"} = $source;
        push @todo, @nested;
    }
    return \%files;
}

# A generated class is one this emitter renders; anything else is stock.
# IO::K8s::AutoGen::class_root is authoritative when it knows the class --
# it is exactly the bookkeeping _nested_class itself relies on, so it is
# never fooled by a name merely looking related. Fall back to the string
# prefix test for anything AutoGen has no record of (a stock class, or a
# class from a namespace this emitter never generated) -- a plain
# index()==0 test on its own would also match a sibling whose name merely
# starts with the same string -- root ...::V1::Knob would wrongly claim
# ...::V1::KnobExtra as its own -- so the fallback still requires the '::'
# boundary (or an exact match on the root itself).
sub _is_generated {
    my ($self, $class) = @_;
    my $root = $self->{_root};
    return 1 if IO::K8s::AutoGen::class_root($class) eq $root;
    return $class eq $root || index($class, "$root\::") == 0;
}

sub _class_ref {
    my ($self, $class) = @_;
    return "'+" . $self->package_for($class) . "'" if $self->_is_generated($class);
    for my $pair (@SHORT_PREFIXES) {
        my ($full, $short) = @$pair;
        next unless index($class, "$full\::") == 0;
        my $rest = substr($class, length($full) + 2);
        return "'" . ($short ? "$short\::$rest" : $rest) . "'";
    }
    return "'+$class'";
}

# The DSL type spec for one registry entry, as source. Returns
# ($source, $nested_class_or_undef). $class/$key are diagnostic context
# only, for the croak below -- the caller already has both.
sub _type_source {
    my ($self, $info, $class, $key) = @_;
    my $nested = $info->{class} && $self->_is_generated($info->{class}) ? $info->{class} : undef;
    return ($self->_class_ref($info->{class}), $nested)                if $info->{is_object};
    return ('[' . $self->_class_ref($info->{class}) . ']', $nested)    if $info->{is_array_of_objects};
    return ('{ ' . $self->_class_ref($info->{class}) . ' => 1 }', $nested) if $info->{is_hash_of_objects};
    return ('[Str]')      if $info->{is_array_of_str};
    return ('[Int]')      if $info->{is_array_of_int};
    return ('[Bool]')     if $info->{is_array_of_bool};
    return ('[ {} ]')     if $info->{is_array_of_hash};
    return ('[ [] ]')     if $info->{is_array_of_array};
    return ('{ Str => 1 }')      if $info->{is_hash_of_str};
    return ('{ Int => 1 }')      if $info->{is_hash_of_int};
    return ('{ Num => 1 }')      if $info->{is_hash_of_num};
    return ('{ Bool => 1 }')     if $info->{is_hash_of_bool};
    return ('{ Quantity => 1 }') if $info->{is_hash_of_quantity};
    return ('{ Time => 1 }')     if $info->{is_hash_of_time};
    return ('{ IntOrStr => 1 }') if $info->{is_hash_of_int_or_string};
    return ('Str')      if $info->{is_str};
    return ('Int')      if $info->{is_int};
    return ('Num')      if $info->{is_num};
    return ('Bool')     if $info->{is_bool};
    return ('IntOrStr') if $info->{is_int_or_string};
    return ('Quantity') if $info->{is_quantity};
    return ('Time')     if $info->{is_time};
    croak "IO::K8s::CRD::Emitter: registry entry with no recognizable type for field '$key' of $class";
}

# A pattern string re-quoted into `qr/.../ ` source is interpolated by Perl
# just like a double-quoted string: an unescaped '@' tries to interpolate an
# array -- '^[a-z]+@example\.com$' would die "Global symbol '@example'
# requires explicit package name" at compile time -- and an unescaped '$'
# not already meaning "end of string/group/alternative" tries to
# interpolate a scalar. '@' is always escaped, unconditionally: '\@' means
# a literal '@' in a regex no matter what follows it, so escaping it can
# never change what the pattern matches, and it is the only way to rule out
# every '@'-led interpolation form at once -- '@name', '@{...}', and
# '@$name'/'@$' (an array deref through a scalar, including the
# punctuation variable $) or $| that '@$' immediately before a bare ')' or
# '|' would reach for). A narrower rule that only escaped '@' before a word
# character or '{' missed exactly that last form: '(a@$)' left both the
# '@' (not followed by \w/{) and the '$' (immediately before ')') bare,
# and '@$)' interpolated away to nothing, silently turning the pattern
# into '(a)'. '$' cannot be escaped unconditionally the same way -- unlike
# '@', a bare '$' is meaningful in a regex (the end-of-string/line anchor),
# so it is only escaped when it is NOT in one of the anchor positions
# ("...$", "(...$)", "...$|...") a schema pattern realistically uses;
# escaping it there would turn the anchor into a literal '$' character
# instead of leaving it as an anchor -- wrong regex, not just wrong Perl.
# Walks the pattern one (possibly backslash-escaped) unit at a time so an
# already-escaped character -- notably a pattern that came in as
# '\/api\/v1' -- is left exactly as it was instead of gaining a second
# backslash.
sub _escape_pattern_body {
    my ($pattern) = @_;
    my $out = '';
    while ($pattern =~ /\G(?:(\\.)|(.))/gs) {
        if (defined $1) {
            $out .= $1;
            next;
        }
        my $c = $2;
        if ($c eq '/') {
            $out .= '\\/';
        }
        elsif ($c eq '@') {
            $out .= '\\@';
        }
        elsif ($c eq '$') {
            my $rest = substr($pattern, pos($pattern));
            $out .= ($rest eq '' || $rest =~ /\A[)|]/) ? '$' : '\\$';
        }
        elsif (ord($c) > 0x7F) {
            # A codepoint above ASCII, interpolated raw into 'qr/.../ ',
            # only round-trips through this emitted .pm file when it is
            # BOTH saved to disk as UTF-8 bytes AND compiled under 'use
            # utf8' -- neither of which this method controls once the
            # caller has the rendered source in hand. \x{HEX} means the
            # same codepoint either way: a schema pattern like
            # '^[0-9]+\x{b5}s$' matches '100\x{b5}s' (100, MICRO SIGN, s)
            # exactly like the generated class does, independent of that
            # pragma. See render()'s own use-utf8/=encoding decision for
            # the one place non-ASCII text still goes into the file
            # unescaped: a schema's free-form 'description', in POD.
            $out .= sprintf('\x{%x}', ord($c));
        }
        else {
            $out .= $c;
        }
    }
    return $out;
}

# A double-quoted Perl string literal that stays ASCII-only regardless of
# what $str holds: '\', '"', '$' and '@' are escaped so the double-quoted
# form -- unlike Data::Dumper's default single-quoted style, this one DOES
# interpolate -- carries nothing but the literal value, and every character
# above ASCII becomes \x{HEX}, the same escape and the same reason as
# _escape_pattern_body above. Single-quoted Perl strings cannot carry a
# \x{...} escape at all (only \\ and \' mean anything inside them), which is
# why a value that needs this can't just be tacked onto Data::Dumper's
# normal single-quoted output.
sub _quote_utf8_string {
    my ($str) = @_;
    (my $escaped = $str) =~ s{ ([\\"\$\@]) | ([^\x00-\x7F]) }{
        defined $1 ? "\\$1" : sprintf('\x{%x}', ord($2))
    }gex;
    return qq{"$escaped"};
}

# One scalar option value (an enum member, or `default`), rendered via
# Data::Dumper's own single-quoted style for anything ASCII -- byte-for-byte
# what every rendered file already produced -- or, for anything that is
# not, via _quote_utf8_string above.
sub _scalar_literal {
    my ($value) = @_;
    return _quote_utf8_string($value)
        if !ref($value) && defined($value) && $value =~ /[^\x00-\x7F]/;
    local $Data::Dumper::Terse    = 1;
    local $Data::Dumper::Indent   = 0;
    local $Data::Dumper::Sortkeys = 1;
    local $Data::Dumper::Useqq    = 0;
    my $dumped = Data::Dumper::Dumper($value);
    $dumped =~ s/^\s+|\s+$//g;
    return $dumped;
}

# A Perl literal for an option value. A Regexp is rendered as qr/.../, read
# back out via re::regexp_pattern in LIST context -- the scalar-context form
# returns the whole "(?^:PATTERN)" wrapper, which is not what a hand-written
# `k8s x => Str, { pattern => qr/.../ };` line looks like anywhere else in
# this distribution. 'u' is dropped from the flags before they are appended:
# every pattern IO::K8s::CRD compiles starts life as a UTF8-flagged string
# out of YAML::PP, and interpolating one into qr/$p/ tags the result with an
# implicit 'u' that reflects nothing the CRD schema's `pattern` asked for --
# rendering it back would forge a modifier into the source. A real modifier
# a pattern did ask for (i, m, s, x) still comes through.
sub _literal {
    my ($value) = @_;
    if (ref $value eq 'Regexp') {
        my ($pattern, $flags) = re::regexp_pattern($value);
        my $body = _escape_pattern_body($pattern);
        $flags =~ s/u//g if defined $flags;
        return "qr/$body/" . ($flags // '');
    }
    if (ref $value eq 'ARRAY' && @$value) {
        # The qw() shorthand only for a list of genuinely bareword-safe
        # values (D6-friendly enum members like Always/IfNotPresent): word
        # characters, dots, colons, dashes and slashes -- ASCII only, never
        # empty. An enum entry that is the empty string -- a real, if
        # unusual, upstream value -- would otherwise vanish: 'qw( Always
        # IfNotPresent)' from ('', 'Always', 'IfNotPresent') silently drops
        # the '', and the emitted class would then reject a value the
        # generated one accepts. A non-ASCII entry is excluded the same
        # way even though Perl's \w matches a Unicode letter like 'µ' when
        # the string carries the UTF8 flag (as one loaded from a CRD
        # manifest does) -- qw() has no escape syntax at all, so a raw
        # non-ASCII byte inside it would be exactly the bug this emitter
        # exists to avoid.
        my $qw_safe = !grep { ref $_ || !defined $_ || $_ !~ /\A[\w.:\/-]+\z/ || $_ =~ /[^\x00-\x7F]/ } @$value;
        return '[qw(' . join(' ', @$value) . ')]' if $qw_safe;
        # Not qw()-safe: render element by element rather than handing the
        # whole arrayref to Data::Dumper, so a non-ASCII element can switch
        # to the double-quoted \x{HEX} form on its own while its ASCII
        # siblings keep Dumper's ordinary single-quoted style -- Dumper has
        # no way to quote just one element of a list differently.
        return '[' . join(',', map { _scalar_literal($_) } @$value) . ']';
    }
    return _scalar_literal($value);
}

my @OPTION_ORDER = qw( required enum minimum maximum pattern default nullable preserve_unknown );

# `required` is rendered as `required => 'schema'`: recorded for the CRD
# schema, never enforced at construction -- the same policy AutoGen applies,
# because a cluster returns `status: {}` for a fresh object whatever the
# status schema requires. A hand-written class that wants enforcement
# writes `'required'` itself.
sub _options_source {
    my ($info) = @_;
    my %opts = %{ $info->{options} // {} };
    delete $opts{description};             # goes to POD
    $opts{required} = 'schema' if $info->{required};
    return '' unless %opts;
    my @parts = map { "$_ => " . _literal($opts{$_}) } grep { exists $opts{$_} } @OPTION_ORDER;
    return ', { ' . join(', ', @parts) . ' }';
}

# The class-level ABSTRACT text from a schema's `description`: every run of
# whitespace (a multi-line description included -- a literal newline in a
# `# ABSTRACT:` comment would not compile) collapsed to one space, then the
# first sentence of that (up to the first '. ' or the end), the same way a
# hand-written class's # ABSTRACT line is one line, not the whole paragraph.
# Returns undef -- never an empty string -- for a missing or whitespace-only
# description, so the caller's fallback triggers on truthiness.
sub _first_sentence {
    my ($text) = @_;
    return undef unless defined $text;
    (my $flat = $text) =~ s/\s+/ /g;
    $flat =~ s/\A\s+|\s+\z//g;
    return undef unless length $flat;
    my ($first) = $flat =~ /\A(.*?\.)(?:\s|\z)/;
    return $first // $flat;
}

# A schema's free-form description lands in POD (the =attr block). Guard
# against it breaking the surrounding document: a line starting with '='
# would open a bogus POD command instead of just being text -- E<61> is the
# POD escape for a literal '=' (ASCII 61) -- and a run of blank lines would
# split the paragraph into several, an artifact of however the upstream
# text happened to be wrapped rather than anything meaningful.
sub _pod_safe {
    my ($text) = @_;
    return $text unless defined $text;
    $text =~ s/^[ \t]+$//gm;
    $text =~ s/\n{3,}/\n\n/g;
    $text =~ s/^=/E<61>/gm;
    return $text;
}

sub _render_class {
    my ($self, $class) = @_;
    my $info  = $class->_k8s_attr_info;
    my $attrs = $class->_k8s_attributes;
    my $is_top = $class->can('_is_resource') ? 1 : 0;
    my $package = $self->package_for($class);

    # `metadata` is registered in the generated class's own registry (D10's
    # AutoGen adds it via the k8s DSL so _inflate_struct knows its type),
    # but no hand-written top-level class ever declares it explicitly --
    # `use IO::K8s::APIObject ...;` already does, the same way this
    # rendered source will. Emitting it again would be a harmless but
    # un-idiomatic duplicate line no template class carries.
    my %skip = $is_top ? (metadata => 1) : ();

    # The printed field name -- quoted when it is not a bareword-safe Perl
    # identifier -- is what actually lines up in the source, so the column
    # width is measured on it, not on the (possibly shorter, unquoted) raw
    # JSON key.
    my %name = map {
        my $key = $info->{$_}{json_key} // $_;
        ($_ => ($key =~ /^[A-Za-z_]\w*$/ ? $key : "'$key'"));
    } grep { !$skip{$_} } @$attrs;

    my @nested;
    my (@lines, @pod);
    my $width = 0;
    for my $attr (@$attrs) {
        next if $skip{$attr};
        $width = length $name{$attr} if length $name{$attr} > $width;
    }
    for my $attr (@$attrs) {
        next if $skip{$attr};
        my $i   = $info->{$attr};
        my $key = $i->{json_key} // $attr;
        my ($type, $nested) = $self->_type_source($i, $class, $key);
        push @nested, $nested if $nested;
        push @lines, sprintf("k8s %-*s => %s%s;", $width, $name{$attr}, $type, _options_source($i));
        my $desc = _pod_safe($i->{options}{description}) // 'No description in the upstream schema.';
        push @pod, "=attr $key\n\n$desc\n\n=cut\n";
    }

    my $abstract = _first_sentence(IO::K8s::AutoGen::class_description($class))
        || ($is_top ? $class->kind : (split /::/, $package)[-1]);
    my $header = join "\n",
        "package $package;",
        "# ABSTRACT: $abstract",
        "our \$VERSION = '" . $self->version . "';";
    my $use;
    if ($is_top) {
        my $plural = $class->resource_plural;
        my @use_lines = (defined $plural && length $plural)
            ? (
                'use IO::K8s::APIObject',
                "    api_version     => '" . $class->api_version . "',",
                "    resource_plural => '$plural';",
              )
            : ("use IO::K8s::APIObject api_version => '" . $class->api_version . "';");
        push @use_lines, "with 'IO::K8s::Role::Namespaced';" if $class->does('IO::K8s::Role::Namespaced');
        $use = join "\n", @use_lines;
    }
    else {
        $use = 'use IO::K8s::Resource;';
    }

    # Every value that could carry non-ASCII text -- a pattern, an enum
    # member, a default -- is already rendered ASCII-only above (\x{HEX}
    # escapes; see _escape_pattern_body / _quote_utf8_string). The one place
    # non-ASCII text still reaches this file unescaped is a schema's
    # free-form 'description', left verbatim in POD (the # ABSTRACT comment
    # above, or an =attr block) by design -- descriptions are documentation,
    # not data a client-side check runs against, so there is nothing to
    # protect by mangling them. 'use utf8' and '=encoding UTF-8' are added
    # together, only when that happens: the former is Perl's own rule for a
    # literal non-ASCII byte anywhere in a file it compiles (POD included),
    # the latter is what a POD viewer needs to decode that text correctly.
    # An all-ASCII file -- the overwhelming majority -- carries neither.
    if (grep { /[^\x00-\x7F]/ } ($header, $use, @lines, @pod)) {
        $header .= "\nuse utf8;";
        unshift @pod, "=encoding UTF-8\n\n=cut\n";
    }

    my $source = join "\n", $header, $use, '', @lines, '', @pod, '1;', '';
    return ($source, @nested);
}

1;
