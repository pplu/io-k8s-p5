package IO::K8s::Api::Core::V1::LimitRange;
# ABSTRACT: LimitRange sets resource usage limits for each kind of resource in a Namespace.
our $VERSION = '1.004';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

LimitRange sets resource usage limits for each kind of resource in a Namespace.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Core::V1::LimitRangeSpec';

=attr spec

Spec defines the limits enforced. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#limitrange-v1-core>


=cut
1;
