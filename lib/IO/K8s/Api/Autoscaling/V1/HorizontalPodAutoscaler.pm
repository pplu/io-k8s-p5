package IO::K8s::Api::Autoscaling::V1::HorizontalPodAutoscaler;
# ABSTRACT: configuration of a horizontal pod autoscaler.

use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=head1 DESCRIPTION

configuration of a horizontal pod autoscaler.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'Autoscaling::V1::HorizontalPodAutoscalerSpec';

=attr spec

spec defines the behaviour of autoscaler. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status.

=cut

k8s status => 'Autoscaling::V1::HorizontalPodAutoscalerStatus';

=attr status

status is the current information about the autoscaler.

=cut

1;
