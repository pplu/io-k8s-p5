package IO::K8s::Api::Flowcontrol::V1::PriorityLevelConfiguration;
# ABSTRACT: PriorityLevelConfiguration represents the configuration of a priority level.
our $VERSION = '1.004';
use IO::K8s::APIObject;

=description

PriorityLevelConfiguration represents the configuration of a priority level.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Flowcontrol::V1::PriorityLevelConfigurationSpec';

=attr spec

`spec` is the specification of the desired behavior of a "request-priority". More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status


=cut

k8s status => 'Flowcontrol::V1::PriorityLevelConfigurationStatus';

=attr status

`status` is the current status of a "request-priority". More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#prioritylevelconfiguration-v1-flowcontrol.apiserver.k8s.io>


=cut
1;
