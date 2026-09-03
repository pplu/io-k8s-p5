package IO::K8s::Role::SpecBuilder;
# ABSTRACT: Role for deep-path spec manipulation on CRD objects
our $VERSION = '1.108';
use Moo::Role;
use Scalar::Util qw(blessed);
use Carp qw(croak);
use Module::Runtime qw(use_module);

# ---------------------------------------------------------------------------
# A node on a spec path is one of: a plain hashref, a plain arrayref, or an
# IO::K8s object (anything composing IO::K8s::Role::Resource). Segments are
# dot-separated. An integer segment indexes an array; -1 is the last element,
# or the one created on an empty array. Anything else is a hash key or, on an
# object, a JSON field name mapped to its attribute through the registry (so
# '$ref' reaches _ref). A field an object does not declare lives in its
# _unknown_fields bag (D1) and is reachable like any other key.
#
# Before 1.109 every method assumed spec was a hashref: on a modeled spec
# spec_set replaced the struct with {} and wrote into an orphan (k90).
# ---------------------------------------------------------------------------

sub _sb_is_obj { blessed($_[0]) && $_[0]->can('_k8s_attr_info') }

sub _sb_is_index { defined $_[0] && $_[0] =~ /\A-?\d+\z/ }

# JSON key -> (attribute name, registry info) on an object; empty list when
# the object declares no such field.
sub _sb_attr {
    my ($node, $key) = @_;
    my $info = $node->_k8s_attr_info;
    for my $attr (keys %$info) {
        return ($attr, $info->{$attr}) if ($info->{$attr}{json_key} // $attr) eq $key;
    }
    return;
}

# Resolve an index against an array for writing. -1 on an empty array is the
# slot a new element goes into; any other index outside the array croaks
# rather than letting Perl autovivify a hole or die on a negative subscript.
sub _sb_index {
    my ($array, $seg, $path) = @_;
    croak "spec path '$path': '$seg' is not an array index" unless _sb_is_index($seg);
    return $seg if $seg >= 0 && $seg <= @$array;
    return 0 if $seg == -1 && !@$array;
    my $resolved = @$array + $seg;
    croak "spec path '$path': index $seg is out of range for an array of " . scalar(@$array)
        if $seg < 0 && $resolved < 0;
    croak "spec path '$path': index $seg is beyond the end of an array of " . scalar(@$array)
        if $seg > @$array;
    return $resolved;
}

# Read one segment. Returns the child, or undef when it is not there. Never
# creates anything.
sub _sb_child {
    my ($node, $seg) = @_;
    if (_sb_is_obj($node)) {
        my ($attr) = _sb_attr($node, $seg);
        return $node->$attr if defined $attr;
        return $node->_unknown_fields->{$seg};
    }
    if (ref $node eq 'ARRAY') {
        return undef unless _sb_is_index($seg);
        return undef if $seg < -@$node || $seg > $#$node;
        return $node->[$seg];
    }
    return $node->{$seg} if ref $node eq 'HASH';
    return undef;
}

# Hand a plain hashref (or an array/hash of them) to a typed slot as objects.
# Uses the shared default IO::K8s instance the way FROM_HASH does: registry
# class names are already fully expanded, so no per-instance resolution is
# involved. Scalars and already-blessed values pass through.
sub _sb_inflate {
    my ($info, $value) = @_;
    return $value unless $info && ref $value;
    my $k8s = IO::K8s::Role::Resource::_default_k8s();
    if ($info->{is_object}) {
        return ref $value eq 'HASH'
            ? $k8s->_struct_to_object_expanded($info->{class}, $value)
            : $value;
    }
    if ($info->{is_array_of_objects} && ref $value eq 'ARRAY') {
        return [ map { _sb_elem($info->{class}, $_) } @$value ];
    }
    if ($info->{is_hash_of_objects} && ref $value eq 'HASH') {
        return { map { $_ => _sb_elem($info->{class}, $value->{$_}) } keys %$value };
    }
    return $value;
}

# One element of an array/hash of objects: a hashref becomes $elem_class.
sub _sb_elem {
    my ($elem_class, $value) = @_;
    return $value unless $elem_class && ref $value eq 'HASH';
    return IO::K8s::Role::Resource::_default_k8s()->_struct_to_object_expanded($elem_class, $value);
}

# Store $value under $seg of $node. A declared field on an object goes
# through its accessor (hashrefs inflated first, so the type constraint sees
# an object); an undeclared one goes into the _unknown_fields bag. Returns
# the value as stored.
sub _sb_store {
    my ($node, $seg, $value, $path, $elem_class) = @_;
    if (_sb_is_obj($node)) {
        my ($attr, $info) = _sb_attr($node, $seg);
        if (defined $attr) {
            $value = _sb_inflate($info, $value);
            $node->$attr($value);
            return $value;
        }
        return $node->_unknown_fields->{$seg} = $value;
    }
    if (ref $node eq 'ARRAY') {
        my $i = _sb_index($node, $seg, $path);
        return $node->[$i] = _sb_elem($elem_class, $value);
    }
    if (ref $node eq 'HASH') {
        return $node->{$seg} = _sb_elem($elem_class, $value);
    }
    croak "spec path '$path': cannot store '$seg' in a " . (ref($node) || 'scalar');
}

# The class of the elements under an array/hash-of-objects field, when the
# node is an object and the field is one; undef otherwise.
sub _sb_elem_class {
    my ($node, $seg) = @_;
    return undef unless _sb_is_obj($node);
    my (undef, $info) = _sb_attr($node, $seg);
    return undef unless $info;
    return $info->{class} if $info->{is_array_of_objects} || $info->{is_hash_of_objects};
    return undef;
}

# What to create in an empty slot so a walk can continue. On an object the
# registry decides: the declared class for a struct/object field, [] or {}
# for the container forms, croak for a scalar. Inside an array or hash of
# objects the element class. Elsewhere the next segment decides: an index
# means an array, anything else a hash.
sub _sb_fresh {
    my ($node, $seg, $next, $elem_class, $path) = @_;
    if (_sb_is_obj($node)) {
        my (undef, $info) = _sb_attr($node, $seg);
        if ($info) {
            return use_module($info->{class})->new if $info->{is_object};
            return [] if grep { $info->{$_} } qw(
                is_array_of_objects is_array_of_str is_array_of_int
                is_array_of_bool is_array_of_hash is_array_of_array
            );
            return {} if grep { $info->{$_} } qw(
                is_hash_of_str is_hash_of_objects is_hash_of_int is_hash_of_num
                is_hash_of_bool is_hash_of_quantity is_hash_of_time
                is_hash_of_int_or_string
            );
            croak "spec path '$path': cannot descend through scalar field '$seg'";
        }
    }
    return use_module($elem_class)->new if $elem_class;
    return _sb_is_index($next) ? [] : {};
}

# The spec node. With $vivify, create it when missing: the declared class
# when spec is a typed field of this object, a plain hash otherwise.
sub _sb_root {
    my ($self, $vivify) = @_;
    my $spec = $self->spec;
    return $spec if ref $spec;
    return undef unless $vivify;
    my (undef, $info) = _sb_is_obj($self) ? _sb_attr($self, 'spec') : ();
    $spec = $info && $info->{is_object} ? use_module($info->{class})->new : {};
    $self->spec($spec);
    return $spec;
}

# Walk to the parent of the last segment, creating what is missing. Returns
# ($parent, $last_segment, $elem_class): $elem_class names the class a new
# element of $parent must be when $parent is an array or hash of objects.
sub _sb_walk_vivify {
    my ($self, $path) = @_;
    my @segs = split /\./, $path;
    my $last = pop @segs;
    croak "spec path '$path' is empty" unless defined $last && length $last;
    my $node = $self->_sb_root(1);
    my $elem_class;
    for my $i (0 .. $#segs) {
        my $seg  = $segs[$i];
        my $next = $i < $#segs ? $segs[$i + 1] : $last;
        my $child = _sb_child($node, $seg);
        if (defined $child && !ref $child) {
            croak "spec path '$path': cannot descend through scalar field '$seg'";
        }
        my $child_elem_class = _sb_elem_class($node, $seg);
        unless (ref $child) {
            $child = _sb_fresh($node, $seg, $next, $elem_class, $path);
            $child = _sb_store($node, $seg, $child, $path, $elem_class);
        }
        # Elements of a container we just entered are typed only when the
        # object we came from declared the container as one of objects.
        $elem_class = $child_elem_class;
        $node = $child;
    }
    return ($node, $last, $elem_class);
}

=method spec_get

    my $value = $obj->spec_get($path);

Reads a value from the object's C<spec> at the dotted path C<$path>. Each
segment is a hash key, an array index (a purely numeric segment, C<-1> for
the last element), or a JSON field name on a typed C<spec> node -- an
inline struct, a referenced class, or an array/hash of either. Returns
C<undef> if any segment along the way is missing, C<spec> itself is unset,
or the terminal value is not defined. Never vivifies.

    my $match = $ir->spec_get('routes.0.match');

=cut

sub spec_get {
    my ($self, $path) = @_;
    my $node = $self->_sb_root(0);
    return undef unless ref $node;
    for my $seg (split /\./, $path) {
        return undef unless ref $node;
        $node = _sb_child($node, $seg);
        return undef unless defined $node;
    }
    return $node;
}

=method spec_set

    $obj->spec_set($path, $value);

Writes C<$value> into the object's C<spec> at the dotted path C<$path>.
Vivifies missing intermediate structure along the way: on a plain hash spec
as a hashref (or arrayref, for a numeric segment), and on a typed spec as
whatever the attribute registry declares for that field -- an inline
struct or referenced class, an array/hash container, or (via the
C<_unknown_fields> bag, D1) a plain hash for a field the class does not
declare. A hashref handed to a declared object/array/hash-of-objects slot
is inflated through the registry the same way C<FROM_HASH> would. Returns
C<$self> for chaining.

    $ir->spec_set('tls.secretName', 'my-cert');

=cut

sub spec_set {
    my ($self, $path, $value) = @_;
    my ($parent, $last, $elem_class) = $self->_sb_walk_vivify($path);
    _sb_store($parent, $last, $value, $path, $elem_class);
    return $self;
}

=method spec_array

    my $arrayref = $obj->spec_array($path);

Vivifies and returns the arrayref at the dotted path C<$path> -- the same
intermediate vivification as C<spec_set>, but returning the container
itself rather than storing a value into it, so the caller can push, splice
or iterate in place. Croaks if the path already holds a defined,
non-array value.

    push @{ $ir->spec_array('entryPoints') }, 'websecure';

=cut

sub spec_array {
    my ($self, $path) = @_;
    my ($parent, $last, $elem_class) = $self->_sb_walk_vivify($path);
    my $array = _sb_child($parent, $last);
    return $array if ref $array eq 'ARRAY';
    croak "spec path '$path': '$last' holds a non-array value" if defined $array;
    return _sb_store($parent, $last, [], $path, $elem_class);
}

=method spec_hash

    my $hashref = $obj->spec_hash($path);

Vivifies and returns the container at the dotted path C<$path> -- a plain
hashref for an opaque map or a struct field, or the struct/object itself
when the declared field is one, so the caller can read or write it
directly. Croaks if the path already holds a defined scalar.

    $ir->spec_hash('tls')->{secretName} = 'my-cert';

=cut

sub spec_hash {
    my ($self, $path) = @_;
    my ($parent, $last, $elem_class) = $self->_sb_walk_vivify($path);
    my $node = _sb_child($parent, $last);
    return $node if ref $node;
    croak "spec path '$path': '$last' holds a scalar" if defined $node;
    my $fresh = _sb_fresh($parent, $last, undef, $elem_class, $path);
    return _sb_store($parent, $last, $fresh, $path, $elem_class);
}

=method spec_push

    $obj->spec_push($path, @values);

Appends C<@values> onto the arrayref located at the dotted path C<$path>,
vivifying it (and its parent structure) as needed via C<spec_array>. A
hashref value handed to an array-of-objects slot is inflated to the
element class, same as C<spec_set>; an already-blessed value is kept as
is. Returns C<$self> for chaining.

    $ir->spec_push('routes', { match => 'Host(`api.example.com`)' });

=cut

sub spec_push {
    my ($self, $path, @values) = @_;
    my $array = $self->spec_array($path);
    my ($parent, $last) = $self->_sb_walk_vivify($path);
    my $item_class = _sb_elem_class($parent, $last);
    push @$array, map { _sb_elem($item_class, $_) } @values;
    return $self;
}

=method spec_merge

    $obj->spec_merge(key1 => $value1, key2 => $value2, ...);

Shallow-merges the given key/value pairs into the top-level C<spec>,
creating it first if the object has none. On a typed spec each key is
written through its declared accessor (with inflation, as C<spec_set>
does) when the class declares it, and into the C<_unknown_fields> bag
(D1) otherwise. Existing keys are overwritten; keys not mentioned in the
merge are left alone. Returns C<$self> for chaining.

    $ir->spec_merge(entryPoints => ['web', 'websecure']);

=cut

sub spec_merge {
    my ($self, %data) = @_;
    my $root = $self->_sb_root(1);
    _sb_store($root, $_, $data{$_}, $_) for keys %data;
    return $self;
}

=method spec_delete

    $obj->spec_delete($path);

Removes the value at the dotted path C<$path>. For a hash parent the key
is deleted (a declared field on a typed node is set to C<undef> through
its accessor rather than removed from the object); for an array parent the
indexed element is spliced out. If the path does not resolve -- C<spec> is
unset, a parent is missing, or the terminal is undefined -- the call is a
no-op. Returns C<$self> for chaining.

    $ir->spec_delete('tls');

=cut

sub spec_delete {
    my ($self, $path) = @_;
    my $node = $self->_sb_root(0);
    return $self unless ref $node;
    my @segs = split /\./, $path;
    my $last = pop @segs;
    for my $seg (@segs) {
        $node = _sb_child($node, $seg);
        return $self unless ref $node;
    }
    if (_sb_is_obj($node)) {
        my ($attr) = _sb_attr($node, $last);
        if (defined $attr) {
            $node->$attr(undef);
        } else {
            delete $node->_unknown_fields->{$last};
        }
    } elsif (ref $node eq 'ARRAY') {
        return $self unless _sb_is_index($last) && @$node;
        return $self if $last < -@$node || $last > $#$node;
        splice @$node, $last, 1;
    } elsif (ref $node eq 'HASH') {
        delete $node->{$last};
    }
    return $self;
}

1;

__END__

=head1 SYNOPSIS

    package My::App;
    use Moo;
    with 'IO::K8s::Role::SpecBuilder';

    has spec => ( is => 'rw' );

    sub BUILD { $_[0]->spec({ routes => [] }) }

    package main;
    my $app = My::App->new;
    $app->spec_push('routes', { match => 'Host(`x`)' });
    $app->spec_set('routes.0.match', 'Host(`y`)');
    print $app->spec_get('routes.0.match');

=head1 DESCRIPTION

This role provides dotted-path get/set/push/merge/delete operations against
a consumer class's C<spec> attribute. It exists so callers building
arbitrary CRDs (IngressRoute, HTTPRoute, Gateway listeners, ...) can reach
deeply-nested fields without writing the indexing by hand each time.

Path syntax: dot-separated segments where each segment is a hash key, with
one exception -- a segment that is purely numeric indexes into the arrayref
at the current position. C<spec_set>, C<spec_push> and C<spec_delete>
vivify missing intermediate hashrefs as needed; C<spec_get> never does.
C<spec_merge> bypasses the path machinery entirely and shallow-merges into
the top level only.

The role is composed automatically by L<IO::K8s::APIObject> on any class
that did not pass C<api_version> as an import parameter (i.e. on every
built-in Kubernetes kind). CRD classes declared via
C<use IO::K8s::APIObject api_version =E<gt> ..., ...> get it the same way;
classes built by L<IO::K8s::AutoGen> at runtime also receive it.

=head1 SEE ALSO

L<IO::K8s::APIObject>, L<IO::K8s::Role::ResourceMap>

=cut