package IO::K8s::AgentSandbox::V1beta1::SandboxWarmPoolStatus;
# ABSTRACT: SandboxWarmPoolStatus
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s observedGeneration => Int, { minimum => 0 };
k8s readyReplicas      => Int;
k8s replicas           => Int;
k8s selector           => Str;

=attr observedGeneration

No description in the upstream schema.

=cut

=attr readyReplicas

No description in the upstream schema.

=cut

=attr replicas

No description in the upstream schema.

=cut

=attr selector

No description in the upstream schema.

=cut

1;
