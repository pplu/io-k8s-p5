package IO::K8s::APIObject;
# ABSTRACT: Base class for top-level Kubernetes API objects

use v5.10;
use IO::K8s::Resource ();
use Import::Into;
use Package::Stash;
use Moo::Role ();

=head1 SYNOPSIS

    package IO::K8s::Api::Core::V1::Pod;
    use IO::K8s::APIObject;

    k8s spec => 'Core::V1::PodSpec';
    k8s status => 'Core::V1::PodStatus';

    1;

=head1 DESCRIPTION

Like L<IO::K8s::Resource>, but for top-level Kubernetes API objects.
Automatically applies L<IO::K8s::Role::APIObject> which provides:

=over 4

=item * C<metadata> attribute

=item * C<api_version()> method (derived from class name)

=item * C<kind()> method (derived from class name)

=back

Use C<IO::K8s::Resource> for embedded objects (PodSpec, Container, etc.)
and C<IO::K8s::APIObject> for top-level resources (Pod, Deployment, Service, etc.)

=cut

sub import {
    my $class = shift;
    my $caller = caller;

    # First, do everything IO::K8s::Resource does
    IO::K8s::Resource->import::into($caller);

    # Then apply the APIObject role
    Moo::Role->apply_roles_to_package($caller, 'IO::K8s::Role::APIObject');
}

1;
