package IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::CustomResourceSubresourceStatus;
# ABSTRACT: Marker that enables the /status subresource for a CRD
our $VERSION = '1.006';
use IO::K8s::Resource;

1;

__END__

=head1 DESCRIPTION

Empty type that signals the Kubernetes API server to enable the
C</status> subresource for a CustomResourceDefinition. When present
in C<subresources.status>, the API server splits the main endpoint
(spec changes only) from the C</status> endpoint (status changes only).

=cut
