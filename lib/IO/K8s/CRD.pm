package IO::K8s::CRD;
# ABSTRACT: Turn CustomResourceDefinition manifests into IO::K8s classes
our $VERSION = '1.108';
use v5.10;
use strict;
use warnings;
use Carp qw( croak );
use Scalar::Util qw( blessed );
use Module::Runtime qw( require_module );
use JSON::MaybeXS ();
use re ();
use IO::K8s::AutoGen ();
use IO::K8s::Resource ();

# The typed class crd_for_class() builds and returns (D9). Kept as a
# constant rather than spelled out at each call site -- the brief's own
# shorthand ('IO::K8s::Apiextensions::Pkg::...') drops the
# 'ApiextensionsApiserver' segment the shipped classes actually use; this
# is the real, checked-in name (see lib/IO/K8s/ApiextensionsApiserver/).
my $CRD_CLASS = 'IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::CustomResourceDefinition';

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
    my $classes = IO::K8s::CRD->generate($crd, $namespace, reuse_core => 0);

Generates one L<IO::K8s::AutoGen> class per served version under
C<$namespace> and returns C<< { $api_version => $class, ..., storage =>
$api_version } >>. C<%opts> is forwarded to
L<IO::K8s::AutoGen/get_or_generate> as-is; C<reuse_core> (D5, default 1) is
the option most callers touch, controlling whether a nested schema that
matches a shipped core class's shape is typed as that class instead of a
generated nested one. The storage version is the one the manifest marks; when
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
    my ($class, $crd, $namespace, %opts) = @_;
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
            %opts,
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

=method crd_for_class

    my $crd = IO::K8s::CRD::crd_for_class($class);
    my $crd = $class->to_crd;   # installed on every APIObject class, see IO::K8s::Role::APIObject

D9: the inverse of L<IO::K8s::AutoGen>'s schema-to-DSL mapping. Builds a
single-version C<CustomResourceDefinition> object from a top-level
C<$class>'s own attribute registry: C<spec.group> and the one
C<spec.versions[]> entry's C<name> come from splitting C<< $class->api_version >>
on the last C</>; C<spec.scope> is C<Namespaced> when C<$class> composes
L<IO::K8s::Role::Namespaced>, else C<Cluster>; C<spec.names> comes from
C<< $class->kind >>, C<< $class->resource_plural >> (C<singular> is
C<lc(kind)>, C<listKind> is C<"${kind}List">); C<metadata.name> is
C<"$plural.$group">. The schema itself is L</_schema_for_class>.

The manifest is assembled as a plain hashref and handed to
L<IO::K8s/_struct_to_object_expanded> -- the same inflation path C<add_crd>
and C<inflate> use -- so the object this returns is a real, fully typed
C<CustomResourceDefinition>: nested C<CustomResourceDefinitionSpec>,
C<CustomResourceDefinitionNames>, C<CustomResourceDefinitionVersion>,
C<CustomResourceValidation> and C<JSONSchemaProps> objects all the way
down, not a bare hashref standing in for them.

=cut

sub crd_for_class {
    my ($class) = @_;
    croak 'IO::K8s::CRD::crd_for_class needs a class name' unless defined $class && length $class;

    my $api_version = $class->api_version;
    my ($group, $version) = $api_version =~ m{\A(?:(.*)/)?([^/]+)\z};
    croak "IO::K8s::CRD::crd_for_class: cannot read a version out of "
        . "'$api_version' (from ${class}->api_version)"
        unless defined $version && length $version;
    $group = '' unless defined $group;

    my $kind   = $class->kind;
    my $plural = $class->resource_plural;
    croak "IO::K8s::CRD::crd_for_class: $class has no resource_plural"
        unless defined $plural && length $plural;

    my $scope = $class->DOES('IO::K8s::Role::Namespaced') ? 'Namespaced' : 'Cluster';

    my $manifest = {
        metadata => { name => "$plural.$group" },
        spec     => {
            group => $group,
            scope => $scope,
            names => {
                plural   => $plural,
                kind     => $kind,
                singular => lc($kind),
                listKind => "${kind}List",
            },
            versions => [ {
                name    => $version,
                served  => JSON::MaybeXS::true,
                storage => JSON::MaybeXS::true,
                schema  => { openAPIV3Schema => _schema_for_class($class) },
            } ],
        },
    };

    require IO::K8s;
    my $k8s = IO::K8s->new;
    return $k8s->_struct_to_object_expanded($CRD_CLASS, $manifest);
}

=method _schema_for_class

    my $schema = IO::K8s::CRD::_schema_for_class($class);

The C<openAPIV3Schema> for one version of C<$class> (D9): walks
C<< $class->_k8s_attr_info >> and mirrors L<IO::K8s::AutoGen>'s
schema-to-DSL mapping (C<_schema_to_type_spec>) field by field, in
reverse, keyed by each field's C<json_key>.

For a top-level Kind (C<< $class->can('_is_resource') >>) the registry's
own C<metadata> entry is skipped and C<apiVersion>/C<kind>/C<metadata>
get the standard envelope stubs instead -- the same three fields
L<IO::K8s::AutoGen>'s C<%role_supplied> excludes when building attributes
FROM a schema (see C<_generate_class> there), lined up here in the
opposite direction. A nested class reached through a field is walked
exactly the same way, minus the stubs (it is never itself C<_is_resource>).

Recursion guards against cycles by tracking the classes already on the
CURRENT path (the second, internal C<$seen> argument -- never pass it from
outside): a class that references itself, directly or through a reused
core class, becomes an opaque
C<< { type => 'object', 'x-kubernetes-preserve-unknown-fields' => true } >>
stub at the repeat instead of recursing forever, the same stub the opaque
C<< { Str => 1 } >> map gets. This is deliberately PATH-scoped, not global:
a class that legitimately appears more than once as unrelated siblings
(C<LabelSelector>, reused all over a real CRD schema per D5) must not be
flattened to that stub on its second, unrelated appearance.

=cut

sub _schema_for_class {
    my ($class, $seen) = @_;
    $seen ||= {};
    return _opaque_object() if $seen->{$class};

    _ensure_class_loaded($class);
    my $info   = $class->_k8s_attr_info;
    my $is_top = $class->can('_is_resource') ? 1 : 0;
    my %next_seen = (%$seen, $class => 1);

    my (%properties, @required);
    for my $attr (sort keys %$info) {
        next if $is_top && $attr eq 'metadata';
        my $entry    = $info->{$attr};
        my $json_key = $entry->{json_key} // $attr;
        $properties{$json_key} = _property_schema($entry, \%next_seen);
        push @required, $json_key if $entry->{required};
    }

    if ($is_top) {
        $properties{apiVersion} = { type => 'string' };
        $properties{kind}       = { type => 'string' };
        $properties{metadata}   = { type => 'object' };
    }

    my %schema = (type => 'object', properties => \%properties);
    $schema{required} = [ sort @required ] if @required;
    return \%schema;
}

# $class already loaded as a file (require_module needed) vs. already
# usable in memory (an inline-struct class the k8s DSL built synchronously
# when its parent's own `k8s foo => { ... }` line ran, or $class itself,
# already loaded by the caller of to_crd/crd_for_class). The inline-struct
# case has no .pm file at all -- require_module would fail "Can't locate
# ... in @INC" for exactly the classes _schema_for_class most needs to
# recurse into. can('_k8s_attr_info') is true the moment
# IO::K8s::Role::Resource is composed onto a package, which happens
# synchronously either way (_generate_inline_struct, or a real file's own
# `use IO::K8s::Resource;` at compile time), so it is the right question
# for both.
sub _ensure_class_loaded {
    my ($class) = @_;
    return if $class->can('_k8s_attr_info');
    require_module($class);
}

sub _property_schema {
    my ($entry, $seen) = @_;
    my $schema = _type_schema($entry, $seen);
    _apply_options($schema, $entry->{options}) if $entry->{options};
    return $schema;
}

# The registry's one classifying is_* flag, turned into its schema shape --
# the reverse of IO::K8s::AutoGen::_schema_to_type_spec's dispatch (and
# IO::K8s::CRD::Emitter::_type_source's DSL-source mirror of the same
# flags, read alongside this while writing it).
#
# is_quantity has no format upstream ever puts on a plain `type: string`
# schema: AutoGen only ever reaches Quantity through a $ref to
# resource.Quantity, never through a format string, so there is nothing to
# emit here that would read back as Quantity. A Quantity field therefore
# round-trips through add_crd as a plain Str -- documented in the task-2
# report, not worked around here. is_time does not share that gap: `format:
# date-time` is exactly what AutoGen's own dispatch reads back into Time,
# so it is emitted, and the round trip is lossless.
sub _type_schema {
    my ($entry, $seen) = @_;

    return { type => 'string' }  if $entry->{is_str};
    return { type => 'integer' } if $entry->{is_int};
    return { type => 'number' }  if $entry->{is_num};
    return { type => 'boolean' } if $entry->{is_bool};
    return { 'x-kubernetes-int-or-string' => JSON::MaybeXS::true } if $entry->{is_int_or_string};
    return { type => 'string' }  if $entry->{is_quantity};
    return { type => 'string', format => 'date-time' } if $entry->{is_time};

    return _schema_for_class($entry->{class}, $seen) if $entry->{is_object};

    return { type => 'array', items => _schema_for_class($entry->{class}, $seen) }
        if $entry->{is_array_of_objects};
    return { type => 'array', items => { type => 'string' } }  if $entry->{is_array_of_str};
    return { type => 'array', items => { type => 'integer' } } if $entry->{is_array_of_int};
    return { type => 'array', items => { type => 'boolean' } } if $entry->{is_array_of_bool};
    return { type => 'array', items => _opaque_object() } if $entry->{is_array_of_hash};
    return { type => 'array', items => { type => 'array' } }   if $entry->{is_array_of_array};

    return { type => 'object', additionalProperties => _schema_for_class($entry->{class}, $seen) }
        if $entry->{is_hash_of_objects};
    # is_hash_of_str is the opaque { Str => 1 } marker itself (see
    # Resource.pm: "the genuinely opaque string map that labels,
    # annotations and fieldsV1 need") -- never a typed additionalProperties
    # schema, unlike every other is_hash_of_* flag below.
    return _opaque_object() if $entry->{is_hash_of_str};
    return { type => 'object', additionalProperties => { type => 'integer' } } if $entry->{is_hash_of_int};
    return { type => 'object', additionalProperties => { type => 'number' } }  if $entry->{is_hash_of_num};
    return { type => 'object', additionalProperties => { type => 'boolean' } } if $entry->{is_hash_of_bool};
    return { type => 'object', additionalProperties => { type => 'string' } }  if $entry->{is_hash_of_quantity};
    return { type => 'object', additionalProperties => { type => 'string', format => 'date-time' } }
        if $entry->{is_hash_of_time};
    return { type => 'object', additionalProperties => { 'x-kubernetes-int-or-string' => JSON::MaybeXS::true } }
        if $entry->{is_hash_of_int_or_string};

    croak 'IO::K8s::CRD::_schema_for_class: registry entry with no recognizable is_* flag';
}

sub _opaque_object {
    return { type => 'object', 'x-kubernetes-preserve-unknown-fields' => JSON::MaybeXS::true };
}

# D3 -> openAPIV3Schema: every option version 1 of D3 carries is emitted
# ("All of them are emitted into the CRD schema (D9)" -- the design spec's
# own words). 'required' is excluded here on purpose -- it is not a
# per-property key, it joins the ENCLOSING object's own 'required' array,
# handled by _schema_for_class's caller loop above.
sub _apply_options {
    my ($schema, $opts) = @_;
    $schema->{enum} = [ @{ $opts->{enum} } ] if exists $opts->{enum};
    $schema->{minimum} = $opts->{minimum} if exists $opts->{minimum};
    $schema->{maximum} = $opts->{maximum} if exists $opts->{maximum};
    if (exists $opts->{pattern}) {
        my $p = $opts->{pattern};
        # re::regexp_pattern in LIST context returns the raw pattern text a
        # qr// was built from -- unlike plain stringification, it carries no
        # '(?^:...)' wrapper, so what lands in the schema is what the author
        # (or AutoGen's own $src->{pattern}) originally wrote. Regex flags
        # (a qr/.../i, say) have no standard JSON Schema carrier and are
        # dropped -- every hand-written 'pattern' in this distribution is
        # case-sensitive, so this has not lost anything real yet; a future
        # flagged pattern would need an explicit decision, not a guess here.
        $schema->{pattern} = (ref $p eq 'Regexp') ? (re::regexp_pattern($p))[0] : $p;
    }
    $schema->{description} = $opts->{description} if exists $opts->{description};
    $schema->{default} = _copy_one_level($opts->{default}) if exists $opts->{default};
    $schema->{nullable} = $opts->{nullable} ? JSON::MaybeXS::true : JSON::MaybeXS::false
        if exists $opts->{nullable};
    $schema->{'x-kubernetes-preserve-unknown-fields'} = $opts->{preserve_unknown} ? JSON::MaybeXS::true : JSON::MaybeXS::false
        if exists $opts->{preserve_unknown};
    return;
}

# One level of copying for a 'default' option that might be an array/hash
# ref -- the registry never copies 'default' itself (only 'enum'; see
# IO::K8s::Resource::_k8s), so a plain assignment here would alias the
# class's own stored default the same way k54 warns against elsewhere.
# Duplicated from IO::K8s::Role::Resource::_copy_one_level rather than
# called cross-package, for the same reason that one gives for not calling
# IO::K8s.pm's version: this file must not force-load IO::K8s at compile
# time (see crd_for_class's own lazy 'require IO::K8s' above).
sub _copy_one_level {
    my ($value) = @_;
    return [ @$value ] if ref $value eq 'ARRAY';
    return { %$value } if ref $value eq 'HASH';
    return $value;
}

1;
