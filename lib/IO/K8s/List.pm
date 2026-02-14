package IO::K8s::List;
# ABSTRACT: Generic list container for Kubernetes API responses
our $VERSION = '1.002';
use v5.10;
use Moo;
use Types::Standard qw( ArrayRef InstanceOf Maybe Str );
use JSON::MaybeXS ();
use Scalar::Util qw(blessed);

=head1 SYNOPSIS

    use IO::K8s::List;

    my $list = IO::K8s::List->new(
        items => \@pods,
        metadata => $list_meta,
    );

    # apiVersion and kind are derived from items
    print $list->api_version;  # v1
    print $list->kind;         # PodList

=head1 DESCRIPTION

Generic container for Kubernetes list responses. Instead of having separate
PodList, ServiceList, DeploymentList classes, this single class handles all
list types.

The C<apiVersion> and C<kind> are automatically derived from the items.

=cut

has items => (
    is => 'ro',
    isa => ArrayRef,
    required => 1,
);

=attr items

Array of Kubernetes API objects. Required.

=cut

has metadata => (
    is => 'ro',
    isa => Maybe[InstanceOf['IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ListMeta']],
);

=attr metadata

List metadata (L<IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ListMeta>).
Contains pagination info like C<continue> and C<resourceVersion>.

=cut

has _item_class => (
    is => 'ro',
    isa => Maybe[Str],
    init_arg => 'item_class',
);

=attr item_class

Optional. The class of items in the list. If not provided, derived from
the first item. Used for empty lists where the type can't be inferred.

=cut

sub api_version {
    my $self = shift;

    # Try to get from first item
    if (@{$self->items} && blessed($self->items->[0]) && $self->items->[0]->can('api_version')) {
        return $self->items->[0]->api_version;
    }

    # Fall back to deriving from item_class
    if (my $class = $self->_item_class) {
        if ($class =~ /^IO::K8s::Api::(\w+)::(\w+)::/) {
            my ($group, $version) = ($1, $2);
            $version = lc($version);
            return $group eq 'Core' ? $version : lc($group) . '/' . $version;
        }
    }

    return undef;
}

=method api_version

Returns the Kubernetes API version, derived from items or item_class.

=cut

sub kind {
    my $self = shift;

    # Try to get from first item
    if (@{$self->items} && blessed($self->items->[0]) && $self->items->[0]->can('kind')) {
        return $self->items->[0]->kind . 'List';
    }

    # Fall back to deriving from item_class
    if (my $class = $self->_item_class) {
        if ($class =~ /::(\w+)$/) {
            return $1 . 'List';
        }
    }

    return undef;
}

=method kind

Returns the Kubernetes kind (e.g., "PodList"), derived from items or item_class.

=cut

sub TO_JSON {
    my $self = shift;
    my %data;

    $data{apiVersion} = $self->api_version if $self->api_version;
    $data{kind} = $self->kind if $self->kind;

    $data{items} = [
        map { blessed($_) && $_->can('TO_JSON') ? $_->TO_JSON : $_ } @{$self->items}
    ];

    if ($self->metadata && blessed($self->metadata) && $self->metadata->can('TO_JSON')) {
        $data{metadata} = $self->metadata->TO_JSON;
    }

    return \%data;
}

sub to_json {
    my $self = shift;
    state $json = JSON::MaybeXS->new->canonical;
    return $json->encode($self->TO_JSON);
}

1;
