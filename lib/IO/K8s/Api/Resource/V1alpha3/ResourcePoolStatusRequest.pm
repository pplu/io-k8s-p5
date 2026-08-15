package IO::K8s::Api::Resource::V1alpha3::ResourcePoolStatusRequest;
# ABSTRACT: ResourcePoolStatusRequest triggers a one-time calculation of resource pool status based on the provided filters. Once status is set, the request is considered complete and will not be reprocessed. Users should delete and recreate requests to get updated information.
our $VERSION = '1.108';
use IO::K8s::APIObject;

=description

ResourcePoolStatusRequest triggers a one-time calculation of resource pool status based on the provided filters. Once status is set, the request is considered complete and will not be reprocessed. Users should delete and recreate requests to get updated information.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Resource::V1alpha3::ResourcePoolStatusRequestSpec', 'required';

=attr spec

Spec defines the filters for which pools to include in the status. The spec is immutable once created.


=cut

k8s status => 'Resource::V1alpha3::ResourcePoolStatusRequestStatus';

=attr status

Status is populated by the controller with the calculated pool status. When status is non-nil, the request is considered complete and the entire object becomes immutable.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.36/#resourcepoolstatusrequest-v1alpha3-resource.k8s.io>


=cut
1;
