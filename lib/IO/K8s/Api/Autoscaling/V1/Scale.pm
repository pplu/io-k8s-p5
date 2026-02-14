package IO::K8s::Api::Autoscaling::V1::Scale;
# ABSTRACT: Scale represents a scaling request for a resource.
our $VERSION = '1.002';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

Scale represents a scaling request for a resource.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Autoscaling::V1::ScaleSpec';

=attr spec

spec defines the behavior of the scale. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status.


=cut

k8s status => 'Autoscaling::V1::ScaleStatus';

=attr status

status is the current status of the scale. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status. Read-only.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#scale-v1-autoscaling.k8s.io>


=cut
1;
