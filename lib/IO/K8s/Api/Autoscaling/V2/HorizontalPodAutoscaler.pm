package IO::K8s::Api::Autoscaling::V2::HorizontalPodAutoscaler;
# ABSTRACT: HorizontalPodAutoscaler is the configuration for a horizontal pod autoscaler, which automatically manages the replica count of any resource implementing the scale subresource based on the metrics specified.

use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=head1 DESCRIPTION

HorizontalPodAutoscaler is the configuration for a horizontal pod autoscaler, which automatically manages the replica count of any resource implementing the scale subresource based on the metrics specified.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'Autoscaling::V2::HorizontalPodAutoscalerSpec';

=attr spec

spec is the specification for the behaviour of the autoscaler. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status.

=cut

k8s status => 'Autoscaling::V2::HorizontalPodAutoscalerStatus';

=attr status

status is the current information about the autoscaler.

=cut

1;
