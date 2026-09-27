package IO::K8s::Manifest;
# ABSTRACT: Internal collector for loading .pk8s manifest files
our $VERSION = '1.109';
use v5.10;
use strict;
use warnings;
use Moo;
use Carp qw(croak);
use Package::Stash;

# Current collector during evaluation
our $_collector;

# Items collected in this manifest
has '_items' => (is => 'ro', default => sub { [] });

# Add resources to manifest
sub add {
    my ($self, @objs) = @_;
    push @{$self->_items}, @objs;
    return $self;
}

# Get all items
sub items {
    my $self = shift;
    return @{$self->_items};
}

# Load .pk8s file - called from IO::K8s->load
sub _load_file {
    my ($class, $file, $k8s, $vars) = @_;

    # Read as UTF-8 (k160), the way load_yaml reads a file (k159): a
    # non-ASCII literal in a manifest gives the same characters as the same
    # value in YAML instead of its UTF-8 bytes. A manifest that says
    # `use utf8;` itself gets the same characters -- the source handed to
    # the eval below already is characters.
    my $content = $k8s->_slurp_utf8($file);

    # Create manifest collector
    my $m = $class->new;

    # Each load evaluates the file in a package of its own and removes that
    # package again afterwards, also when the load fails (k160). It holds
    # one DSL sub per known Kind, about 850 KB, and used to stay behind after
    # every call, so a process reloading manifests in a loop grew without
    # bound. Only the stash entry is deleted, not Symbol::delete_package:
    # that one undefs every glob first, which would empty the subs and
    # package variables a closure the manifest handed out still calls. With
    # just the entry gone, whatever is still referenced -- such closures,
    # the globs they use, an object blessed into the package -- lives on,
    # and the rest is freed.
    my $leaf = "_LOADER_$$" . "_" . int(rand(100000));
    my $pkg  = __PACKAGE__ . '::' . $leaf;

    my $ok = eval {
        local $_collector = $m;

        $class->_install_var($pkg, $file, $vars);

        # Build the DSL code with functions for all resource types
        my $dsl_code = _build_dsl_code($k8s);

        # Eval the file content with DSL available
        my $eval_code = qq{
            package $pkg;
            use strict;
            use warnings;
            $dsl_code
            $content
        };

        eval $eval_code;
        die "Error loading $file: $@" if $@;
        1;
    };
    my $error = $@;
    delete $IO::K8s::Manifest::{ $leaf . '::' };
    die $error unless $ok;

    return [ $m->items ];
}

# var() for the manifest evaluated in $pkg (k160): var($name) returns the
# value passed as load($file, vars => { $name => ... }), var($name,
# $default) falls back to $default, and a name with neither dies naming the
# file. A closure over this load's own copy of the values, installed before
# the file compiles so that var(...) parses as a call -- and lower case, so
# it can never be taken for a Kind function. The values are never
# interpolated into code.
sub _install_var {
    my ($class, $pkg, $file, $vars) = @_;
    my %vars = %{ $vars // {} };
    Package::Stash->new($pkg)->add_symbol('&var', sub {
        my ($name, @default) = @_;
        croak 'var() needs a name in '.$file unless defined $name;
        return $vars{$name} if exists $vars{$name};
        return $default[0] if @default;
        croak "var('".$name."'): no value passed to ".$file.' and no default given';
    });
    return;
}

# Build DSL code with resource functions
sub _build_dsl_code {
    my ($k8s) = @_;

    my $code = '';

    # Get all resource types from the k8s instance
    my $map = $k8s->resource_map;

    for my $kind (keys %$map) {
        # Skip domain-qualified names (contain /) - not valid Perl identifiers
        next if $kind =~ m{/};

        $code .= qq{
            sub $kind (&@) {
                my \$block = shift;
                my \$api_version = shift;
                my \%args = \$block->();

                # Convenience: move name/namespace/labels/annotations to metadata
                for my \$key (qw(name namespace labels annotations)) {
                    if (exists \$args{\$key}) {
                        \$args{metadata}{\$key} = delete \$args{\$key};
                    }
                }

                my \$k8s = \$IO::K8s::Manifest::_k8s_instance;
                my \$obj = \$api_version
                    ? \$k8s->new_object('$kind', \\\%args, \$api_version)
                    : \$k8s->new_object('$kind', \\\%args);

                \$IO::K8s::Manifest::_collector->add(\$obj)
                    if \$IO::K8s::Manifest::_collector;

                return \$obj;
            }
        };
    }

    return $code;
}

# K8s instance for DSL functions (set during load)
our $_k8s_instance;

1;

__END__

=encoding UTF-8

=head1 NAME

IO::K8s::Manifest - Internal collector for loading .pk8s manifest files

=head1 DESCRIPTION

This is an internal class used by L<IO::K8s/load> to load C<.pk8s> manifest
files. You should not use this class directly.

See L<IO::K8s/load> for documentation on loading manifest files.

=head1 SEE ALSO

L<IO::K8s>

=cut
