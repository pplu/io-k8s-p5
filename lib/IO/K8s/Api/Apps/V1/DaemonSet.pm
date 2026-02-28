package IO::K8s::Api::Apps::V1::DaemonSet;
# ABSTRACT: DaemonSet represents the configuration of a daemon set.
our $VERSION = '1.004';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

DaemonSet represents the configuration of a daemon set.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Apps::V1::DaemonSetSpec';

=attr spec

The desired behavior of this daemon set. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status


=cut

k8s status => 'Apps::V1::DaemonSetStatus';

=attr status

The current status of this daemon set. This data may be out of date by some window of time. Populated by the system. Read-only. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#daemonset-v1-apps>


=cut
1;
