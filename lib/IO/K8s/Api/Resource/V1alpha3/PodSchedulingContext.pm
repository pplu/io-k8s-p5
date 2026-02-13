package IO::K8s::Api::Resource::V1alpha3::PodSchedulingContext;
# ABSTRACT: PodSchedulingContext objects hold information that is needed to schedule a Pod with ResourceClaims that use "WaitForFirstConsumer" allocation mode. This is an alpha type and requires enabling the DRAControlPlaneController feature gate.
our $VERSION = '1.001';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

PodSchedulingContext objects hold information that is needed to schedule a Pod with ResourceClaims that use "WaitForFirstConsumer" allocation mode.

This is an alpha type and requires enabling the DRAControlPlaneController feature gate.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Resource::V1alpha3::PodSchedulingContextSpec', 'required';

=attr spec

Spec describes where resources for the Pod are needed.


=cut

k8s status => 'Resource::V1alpha3::PodSchedulingContextStatus';

=attr status

Status describes where resources for the Pod can be allocated.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#podschedulingcontext-v1alpha3-resource.k8s.io>


=cut
1;
