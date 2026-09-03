package IO::K8s::CRD::Emitter;
# ABSTRACT: Render generated IO::K8s classes as house-style Perl source
our $VERSION = '1.108';
use v5.10;
use Moo;
use Carp qw( croak );
use Data::Dumper ();
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

=cut

sub package_for {
    my ($self, $class) = @_;
    my $root = $self->{_root} // croak 'package_for needs a render() first';
    return $self->base . '::' . $self->names->{$class} if $self->names->{$class};
    (my $rel = $class) =~ s/^\Q$root\E(?:::)?//;
    my $kind = (split /::/, $root)[-1];
    my $joined = join '', $kind, split /::/, $rel;
    return $self->base . '::' . $joined;
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
sub _is_generated {
    my ($self, $class) = @_;
    return index($class, $self->{_root}) == 0;
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
# ($source, $nested_class_or_undef).
sub _type_source {
    my ($self, $info) = @_;
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
    croak 'IO::K8s::CRD::Emitter: registry entry with no recognizable type';
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
        (my $body = $pattern) =~ s{/}{\\/}g;
        $flags =~ s/u//g if defined $flags;
        return "qr/$body/" . ($flags // '');
    }
    if (ref $value eq 'ARRAY' && @$value && !grep { ref $_ || /[\s'\\()]/ } @$value) {
        return '[qw(' . join(' ', @$value) . ')]';
    }
    local $Data::Dumper::Terse    = 1;
    local $Data::Dumper::Indent   = 0;
    local $Data::Dumper::Sortkeys = 1;
    local $Data::Dumper::Useqq    = 0;
    my $dumped = Data::Dumper::Dumper($value);
    $dumped =~ s/^\s+|\s+$//g;
    return $dumped;
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

# The class-level ABSTRACT text from a schema's `description`: the first
# sentence (up to the first '. ' or the end of the string), the same way a
# hand-written class's # ABSTRACT line is one line, not the whole paragraph.
sub _first_sentence {
    my ($text) = @_;
    return $text unless defined $text;
    my ($first) = $text =~ /\A(.*?\.)(?:\s|\z)/s;
    return $first // $text;
}

sub _render_class {
    my ($self, $class) = @_;
    my $info  = IO::K8s::Role::Resource::_k8s_attr_info($class);
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

    my @nested;
    my (@lines, @pod);
    my $width = 0;
    for my $attr (@$attrs) {
        next if $skip{$attr};
        my $key = $info->{$attr}{json_key} // $attr;
        $width = length $key if length $key > $width;
    }
    for my $attr (@$attrs) {
        next if $skip{$attr};
        my $i   = $info->{$attr};
        my $key = $i->{json_key} // $attr;
        my ($type, $nested) = $self->_type_source($i);
        push @nested, $nested if $nested;
        my $name = $key =~ /^[A-Za-z_]\w*$/ ? $key : "'$key'";
        push @lines, sprintf("k8s %-*s => %s%s;", $width, $name, $type, _options_source($i));
        my $desc = $i->{options}{description} // 'No description in the upstream schema.';
        push @pod, "=attr $key\n\n$desc\n\n=cut\n";
    }

    my $abstract = _first_sentence(IO::K8s::AutoGen::class_description($class))
        // ($is_top ? $class->kind : (split /::/, $package)[-1]);
    my $header = join "\n",
        "package $package;",
        "# ABSTRACT: $abstract",
        "our \$VERSION = '" . $self->version . "';";
    my $use = $is_top
        ? join("\n",
            'use IO::K8s::APIObject',
            "    api_version     => '" . $class->api_version . "',",
            "    resource_plural => '" . ($class->resource_plural // '') . "';",
            ($class->does('IO::K8s::Role::Namespaced') ? "with 'IO::K8s::Role::Namespaced';" : ()),
          )
        : 'use IO::K8s::Resource;';

    my $source = join "\n", $header, $use, '', @lines, '', @pod, '1;', '';
    return ($source, @nested);
}

1;
