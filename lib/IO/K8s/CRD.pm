package IO::K8s::CRD;
# ABSTRACT: Turn CustomResourceDefinition manifests into IO::K8s classes
our $VERSION = '1.108';
use v5.10;
use strict;
use warnings;
use Carp qw( croak );
use Scalar::Util qw( blessed );
use IO::K8s::AutoGen ();
use IO::K8s::Resource ();

=head1 SYNOPSIS

    use IO::K8s;
    my $k8s = IO::K8s->new;
    $k8s->add_crd('crds/knobs.yaml');          # a path, YAML/JSON text, a hashref,
                                               # a CustomResourceDefinition object,
                                               # or an arrayref of those
    my $knob = $k8s->new_object('Knob', ...);   # storage version
    my $old  = $k8s->new_object('opts.example.com/v1alpha1/Knob', ...);

    # The pieces, for callers that want them separately:
    my $crds     = IO::K8s::CRD->load($input);            # plain hashrefs
    my $versions = IO::K8s::CRD->served_versions($crds->[0]);
    my $classes  = IO::K8s::CRD->generate($crds->[0], 'My::Namespace');

=head1 DESCRIPTION

The manifest-to-class half of D10 in the CRD design: a
C<CustomResourceDefinition> is loaded from whatever form the caller has,
every B<served> version of it becomes one L<IO::K8s::AutoGen> class (with
nested classes for every object below C<spec>), and L<IO::K8s/add_crd>
registers them the way a provider's resource map is registered. Nothing
here writes files; L<IO::K8s::CRD::Emitter> renders the same classes as
source for the checked-in case.

=cut

=method load

    my $crds = IO::K8s::CRD->load($input);

Normalizes C<$input> to an arrayref of plain CRD hashrefs. Accepts a
C<CustomResourceDefinition> object (anything with C<TO_JSON>), a hashref,
YAML or JSON text (multi-document YAML yields several), a path to such a
file, or an arrayref of any of those. Dies on a document that is not a
C<CustomResourceDefinition> or lacks C<spec.group>, C<spec.names.kind> or
C<spec.versions>.

=cut

sub load {
    my ($class, $input) = @_;
    croak 'IO::K8s::CRD->load needs a CustomResourceDefinition object, a hashref, YAML/JSON text or a file path'
        unless defined $input;

    my @docs;
    if (ref $input eq 'ARRAY') {
        return [ map { @{ $class->load($_) } } @$input ];
    }
    elsif (blessed($input) && $input->can('TO_JSON')) {
        @docs = ($input->TO_JSON);
    }
    elsif (ref $input eq 'HASH') {
        @docs = ($input);
    }
    elsif (!ref $input) {
        my $text = $input;
        if ($input !~ /\n/ && -f $input) {
            open my $fh, '<:encoding(UTF-8)', $input
                or croak "IO::K8s::CRD->load: cannot open $input: $!";
            $text = do { local $/; <$fh> };
            close $fh;
        }
        require YAML::PP;
        my $yp = YAML::PP->new(boolean => 'JSON::PP');
        @docs = grep { ref $_ eq 'HASH' } $yp->load_string($text);
    }
    else {
        croak 'IO::K8s::CRD->load: unsupported input ' . ref($input);
    }

    for my $i (0 .. $#docs) {
        my $doc = $docs[$i];
        my $kind = $doc->{kind} // '';
        croak 'IO::K8s::CRD->load: document ' . ($i + 1) . " is a '$kind', not a CustomResourceDefinition"
            unless $kind eq 'CustomResourceDefinition';
        croak 'IO::K8s::CRD->load: CustomResourceDefinition without spec.group / spec.names.kind / spec.versions'
            unless ref $doc->{spec} eq 'HASH'
                && defined $doc->{spec}{group}
                && ref $doc->{spec}{names} eq 'HASH' && defined $doc->{spec}{names}{kind}
                && ref $doc->{spec}{versions} eq 'ARRAY' && @{ $doc->{spec}{versions} };
    }
    return \@docs;
}

# served / storage arrive as JSON booleans, plain 0/1, or the strings a
# hand-written YAML may carry; the DSL's one boolean normalization decides.
# A missing field is a legitimate "not set" and stays 0/false; a field that
# IS present but cannot mean true or false (an arrayref, say) must not be
# swallowed into the same "not set" answer -- croak instead, naming the
# version index and field so the manifest is easy to find.
sub _flag {
    my ($value, $field, $index) = @_;
    return 0 unless defined $value;
    my $bool = eval { IO::K8s::Resource::_normalize_bool($value) };
    croak "IO::K8s::CRD: spec.versions[$index].$field is not a boolean" if $@;
    return $bool ? 1 : 0;
}

=method served_versions

    my $versions = IO::K8s::CRD->served_versions($crd);

The served versions of one loaded CRD, in manifest order, each as
C<< { name, api_version, storage, schema } >> where C<schema> is the
version's C<openAPIV3Schema> (an empty C<type: object> when the manifest has
none). Dies when no version is served.

=cut

sub served_versions {
    my ($class, $crd) = @_;
    my $group = $crd->{spec}{group};
    my $versions = $crd->{spec}{versions};
    my @out;
    for my $i (0 .. $#$versions) {
        my $v = $versions->[$i];
        next unless _flag($v->{served}, 'served', $i);
        push @out, {
            name        => $v->{name},
            api_version => "$group/$v->{name}",
            storage     => _flag($v->{storage}, 'storage', $i),
            # A plain '$v->{schema}{openAPIV3Schema}' would autovivify
            # $v->{schema} into {} on a version that has none, silently
            # mutating the caller's manifest hashref -- ref() first, so a
            # missing/undef 'schema' is read without creating it.
            schema      => (ref $v->{schema} eq 'HASH' ? $v->{schema}{openAPIV3Schema} : undef) // { type => 'object' },
        };
    }
    croak "IO::K8s::CRD: no served version in the CRD for $crd->{spec}{names}{kind}" unless @out;
    return \@out;
}

=method generate

    my $classes = IO::K8s::CRD->generate($crd, $namespace);

Generates one L<IO::K8s::AutoGen> class per served version under
C<$namespace> and returns C<< { $api_version => $class, ..., storage =>
$api_version } >>. The storage version is the one the manifest marks; when
none is marked (an invalid manifest, but a common one in hand-written
fixtures) the last served version is used. Each class carries the CRD's
C<kind>, C<names.plural> and scope, and every object with C<properties>
below it is a nested class (see L<IO::K8s::AutoGen>).

Classes are generated under C<$namespace\::_CRD>, never C<$namespace>
itself. L<IO::K8s::AutoGen> caches by class name, and the class name is
derived from the namespace plus the group/version/Kind (see
L<IO::K8s::AutoGen/get_or_generate>) -- not from the schema, and not
differently for a CRD manifest than for an C<openapi_spec> definition of
the same GVK. Under a shared namespace the two paths would therefore build
the identical class name for the identical GVK and alias in AutoGen's
cache: whichever ran first would win the slot, and the CRD's own
schema-derived class would silently be discarded (or would silently
clobber the C<openapi_spec> one) while C<< $k8s->add_crd >> still reported
success. The C<::_CRD> sub-namespace rules that out.

Calling C<generate> a second time for the same group/version/Kind under
the same C<$namespace> returns the class generated the first time,
silently, even when the schema in C<$crd> has since changed -- the
sub-namespace does not change that, it only stops the CRD path from
colliding with a different one. Iterating on an edited manifest needs a
fresh C<$namespace> (in practice: a fresh L<IO::K8s> instance, since
L<IO::K8s/add_crd> always passes its own C<_autogen_namespace>). Generated
classes live for the life of the process regardless -- see
L<IO::K8s/add_crd>'s POD for what that costs a long-running caller that
reloads manifests in a loop.

=cut

sub generate {
    my ($class, $crd, $namespace) = @_;
    my $spec  = $crd->{spec};
    my $group = $spec->{group};
    my $kind  = $spec->{names}{kind};
    my $namespaced = ($spec->{scope} // 'Namespaced') eq 'Namespaced' ? 1 : 0;

    # See the POD above: a sub-namespace of our own so a CRD-derived class
    # can never alias with one AutoGen would build straight from an
    # openapi_spec definition of the same GVK under the caller's namespace.
    my $crd_namespace = "$namespace\::_CRD";

    my %out;
    my $fallback;
    for my $v (@{ $class->served_versions($crd) }) {
        my $def_name = join '.', $group, $v->{name}, $kind;
        my $schema = {
            %{ $v->{schema} },
            'x-kubernetes-group-version-kind' => [ { group => $group, version => $v->{name}, kind => $kind } ],
        };
        $out{ $v->{api_version} } = IO::K8s::AutoGen::get_or_generate(
            $def_name, $schema, {}, $crd_namespace,
            api_version     => $v->{api_version},
            kind            => $kind,
            resource_plural => $spec->{names}{plural},
            is_namespaced   => $namespaced,
        );
        # Track every served version as the fallback so the LAST one wins
        # when none is marked storage -- matching the POD above. An explicit
        # storage:true always overrides it, regardless of position.
        $fallback = $v->{api_version};
        $out{storage} = $v->{api_version} if $v->{storage};
    }
    $out{storage} //= $fallback;
    return \%out;
}

1;
