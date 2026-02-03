package IO::K8s::Api::Resource::V1alpha3::PodSchedulingContext;
# ABSTRACT: PodSchedulingContext objects hold information that is needed to schedule a Pod with ResourceClaims that use "WaitForFirstConsumer" allocation mode. This is an alpha type and requires enabling the DRAControlPlaneController feature gate.

use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=head1 DESCRIPTION

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

1;
