package IO::K8s::AgentSandbox::V1beta1::SandboxClaimStatus;
# ABSTRACT: SandboxClaimStatus
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conditions => ['Meta::V1::Condition'];
k8s sandbox    => '+IO::K8s::AgentSandbox::V1beta1::SandboxClaimStatusSandbox';

=attr conditions

No description in the upstream schema.

=cut

=attr sandbox

No description in the upstream schema.

=cut

1;
