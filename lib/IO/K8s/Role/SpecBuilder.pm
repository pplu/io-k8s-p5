package IO::K8s::Role::SpecBuilder;
# ABSTRACT: Role for deep-path spec manipulation on CRD objects
our $VERSION = '1.108';
use Moo::Role;
use Scalar::Util qw(looks_like_number);

sub _walk_path {
    my ($data, $path, $vivify) = @_;
    my @parts = split /\./, $path;
    my $last_key = pop @parts;
    my $current = $data;

    for my $part (@parts) {
        if (ref $current eq 'ARRAY' && $part =~ /^\d+$/) {
            if ($vivify && !defined $current->[$part]) {
                $current->[$part] = {};
            }
            $current = $current->[$part];
        } elsif (ref $current eq 'HASH') {
            if ($vivify && !defined $current->{$part}) {
                # Look ahead: if next step is numeric, create array
                my $idx = 0;
                for my $p (@parts, $last_key) {
                    last if $p eq $part;
                    $idx++;
                }
                $current->{$part} = {};
            }
            $current = $current->{$part};
        } else {
            return (undef, undef) unless $vivify;
            return (undef, undef);
        }
    }

    return ($current, $last_key);
}

=method spec_get

    my $value = $obj->spec_get($path);

Reads a value from the object's C<spec> hashref at the dotted path C<$path>.
Each segment of the path is a hash key; a purely numeric segment indexes into
an arrayref at that position. Returns C<undef> if any segment along the way
is missing, the C<spec> itself is not a hashref, or the terminal value is
not defined. Does not vivify missing intermediate structure.

    my $match = $ir->spec_get('routes.0.match');

=cut

sub spec_get {
    my ($self, $path) = @_;
    my $spec = $self->spec;
    return undef unless ref $spec eq 'HASH';

    my @parts = split /\./, $path;
    my $current = $spec;

    for my $part (@parts) {
        if (ref $current eq 'ARRAY' && $part =~ /^\d+$/) {
            $current = $current->[$part];
        } elsif (ref $current eq 'HASH') {
            $current = $current->{$part};
        } else {
            return undef;
        }
        return undef unless defined $current;
    }

    return $current;
}

=method spec_set

    $obj->spec_set($path, $value);

Writes C<$value> into the object's C<spec> at the dotted path C<$path>.
Vivifies missing intermediate structure as hashrefs, creating an empty
C<spec> first if the object has none. A numeric final segment writes into
an arrayref at that position; a non-numeric segment writes into a hashref.
Returns C<$self> for chaining.

    $ir->spec_set('tls.secretName', 'my-cert');

=cut

sub spec_set {
    my ($self, $path, $value) = @_;
    my $spec = $self->spec;
    unless (ref $spec eq 'HASH') {
        $spec = {};
        $self->spec($spec);
    }

    my @parts = split /\./, $path;
    my $last_key = pop @parts;
    my $current = $spec;

    for my $part (@parts) {
        if (ref $current eq 'ARRAY' && $part =~ /^\d+$/) {
            $current->[$part] = {} unless ref $current->[$part];
            $current = $current->[$part];
        } elsif (ref $current eq 'HASH') {
            $current->{$part} = {} unless ref $current->{$part};
            $current = $current->{$part};
        }
    }

    if (ref $current eq 'ARRAY' && $last_key =~ /^\d+$/) {
        $current->[$last_key] = $value;
    } elsif (ref $current eq 'HASH') {
        $current->{$last_key} = $value;
    }

    return $self;
}

=method spec_push

    $obj->spec_push($path, @values);

Appends C<@values> onto an arrayref located at the dotted path C<$path>.
Vivifies the parent structure as needed and creates the terminal array if
it does not yet exist. A numeric final segment is treated as an array index
into an existing array. Returns C<$self> for chaining.

    $ir->spec_push('routes', { match => 'Host(`api.example.com`)' });

=cut

sub spec_push {
    my ($self, $path, @values) = @_;
    my $spec = $self->spec;
    unless (ref $spec eq 'HASH') {
        $spec = {};
        $self->spec($spec);
    }

    my @parts = split /\./, $path;
    my $last_key = pop @parts;
    my $current = $spec;

    for my $part (@parts) {
        if (ref $current eq 'ARRAY' && $part =~ /^\d+$/) {
            $current->[$part] = {} unless ref $current->[$part];
            $current = $current->[$part];
        } elsif (ref $current eq 'HASH') {
            $current->{$part} = {} unless ref $current->{$part};
            $current = $current->{$part};
        }
    }

    if (ref $current eq 'ARRAY' && $last_key =~ /^\d+$/) {
        $current->[$last_key] = [] unless ref $current->[$last_key] eq 'ARRAY';
        push @{$current->[$last_key]}, @values;
    } elsif (ref $current eq 'HASH') {
        $current->{$last_key} = [] unless ref $current->{$last_key} eq 'ARRAY';
        push @{$current->{$last_key}}, @values;
    }

    return $self;
}

=method spec_merge

    $obj->spec_merge(key1 => $value1, key2 => $value2, ...);

Shallow-merges the given key/value pairs into the top-level C<spec>
hashref. Creates an empty C<spec> if the object has none. Existing keys are
overwritten by the new values; keys not mentioned in the merge are left
alone. Returns C<$self> for chaining.

    $ir->spec_merge(entryPoints => ['web', 'websecure']);

=cut

sub spec_merge {
    my ($self, %data) = @_;
    my $spec = $self->spec;
    unless (ref $spec eq 'HASH') {
        $spec = {};
        $self->spec($spec);
    }
    @{$spec}{keys %data} = values %data;
    return $self;
}

=method spec_delete

    $obj->spec_delete($path);

Removes the value at the dotted path C<$path>. For a hashref parent the
key is deleted; for an arrayref parent the indexed element is spliced out.
If the path does not resolve -- the C<spec> is not a hashref, a parent is
missing, or the terminal is undefined -- the call is a no-op and returns
C<$self>. Returns C<$self> for chaining.

    $ir->spec_delete('tls');

=cut

sub spec_delete {
    my ($self, $path) = @_;
    my $spec = $self->spec;
    return $self unless ref $spec eq 'HASH';

    my @parts = split /\./, $path;
    my $last_key = pop @parts;
    my $current = $spec;

    for my $part (@parts) {
        if (ref $current eq 'ARRAY' && $part =~ /^\d+$/) {
            $current = $current->[$part];
        } elsif (ref $current eq 'HASH') {
            $current = $current->{$part};
        } else {
            return $self;
        }
        return $self unless defined $current;
    }

    if (ref $current eq 'HASH') {
        delete $current->{$last_key};
    } elsif (ref $current eq 'ARRAY' && $last_key =~ /^\d+$/) {
        splice @$current, $last_key, 1;
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