package IO::K8s::Api::Flowcontrol::V1beta3::PriorityLevelConfiguration;
# ABSTRACT: PriorityLevelConfiguration represents the configuration of a priority level.

use IO::K8s::APIObject;

=head1 DESCRIPTION

PriorityLevelConfiguration represents the configuration of a priority level.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'Flowcontrol::V1beta3::PriorityLevelConfigurationSpec';

=attr spec

C<spec> is the specification of the desired behavior of a "request-priority". More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

k8s status => 'Flowcontrol::V1beta3::PriorityLevelConfigurationStatus';

=attr status

C<status> is the current status of a "request-priority". More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

1;
