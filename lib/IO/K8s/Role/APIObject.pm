package IO::K8s::Role::APIObject;
# ABSTRACT: Role for top-level Kubernetes API objects

use Moo::Role;
use Types::Standard qw( InstanceOf Maybe );

=head1 DESCRIPTION

This role is automatically applied when using C<IO::K8s::APIObject>.
It provides the C<metadata> attribute and auto-derives C<apiVersion> and C<kind>
from the class name.

Note: The metadata attribute is registered in IO::K8s::APIObject's import
to ensure proper class registration for inflation.

=cut

has metadata => (
    is => 'ro',
    isa => Maybe[InstanceOf['IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta']],
);

=attr metadata

Standard object's metadata. See L<IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta>.

=cut

# Derive apiVersion from class name
# IO::K8s::Api::Core::V1::Pod -> v1
# IO::K8s::Api::Apps::V1::Deployment -> apps/v1
sub api_version {
    my ($self) = @_;
    my $class = ref($self) || $self;

    if ($class =~ /^IO::K8s::Api::(\w+)::(\w+)::/) {
        my ($group, $version) = ($1, $2);
        $version = lc($version);
        return $group eq 'Core' ? $version : lc($group) . '/' . $version;
    }
    return undef;
}

=method api_version

Returns the Kubernetes API version derived from the class name.

    $pod->api_version;  # "v1"
    $deployment->api_version;  # "apps/v1"

=cut

sub kind {
    my ($self) = @_;
    my $class = ref($self) || $self;

    if ($class =~ /::(\w+)$/) {
        return $1;
    }
    return undef;
}

=method kind

Returns the Kubernetes kind derived from the class name.

    $pod->kind;  # "Pod"
    $deployment->kind;  # "Deployment"

=cut

sub _is_resource { 1 }

sub to_yaml {
    my ($self) = @_;
    require YAML::PP;
    return YAML::PP::Dump($self->TO_JSON);
}

=method to_yaml

    my $yaml = $pod->to_yaml;

Serialize the object to YAML format suitable for C<kubectl apply -f>.

=cut

sub save {
    my ($self, $file) = @_;
    open my $fh, '>', $file or die "Cannot write to $file: $!";
    print $fh $self->to_yaml;
    close $fh;
    return $self;
}

=method save

    $pod->save('pod.yaml');

Save the object to a YAML file. Returns the object for chaining.

=cut

1;
