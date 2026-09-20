package IO::K8s::Cilium::V2::NetworkPolicyCondition;
# ABSTRACT: NetworkPolicyCondition
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s lastTransitionTime => Time;
k8s message            => Str;
k8s reason             => Str;
k8s status             => Str, { required => 'schema' };
k8s type               => Str, { required => 'schema' };

=attr lastTransitionTime

The last time the condition transitioned from one status to another.

=cut

=attr message

A human readable message indicating details about the transition.

=cut

=attr reason

The reason for the condition's last transition.

=cut

=attr status

The status of the condition, one of True, False, or Unknown

=cut

=attr type

The type of the policy condition

=cut

1;
