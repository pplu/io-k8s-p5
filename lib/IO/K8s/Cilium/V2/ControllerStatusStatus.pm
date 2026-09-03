package IO::K8s::Cilium::V2::ControllerStatusStatus;
# ABSTRACT: Status is the status of the controller
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s 'consecutive-failure-count' => Int;
k8s 'failure-count'             => Int;
k8s 'last-failure-msg'          => Str;
k8s 'last-failure-timestamp'    => Str;
k8s 'last-success-timestamp'    => Str;
k8s 'success-count'             => Int;

=attr consecutive-failure-count

No description in the upstream schema.

=cut

=attr failure-count

No description in the upstream schema.

=cut

=attr last-failure-msg

No description in the upstream schema.

=cut

=attr last-failure-timestamp

No description in the upstream schema.

=cut

=attr last-success-timestamp

No description in the upstream schema.

=cut

=attr success-count

No description in the upstream schema.

=cut

1;
