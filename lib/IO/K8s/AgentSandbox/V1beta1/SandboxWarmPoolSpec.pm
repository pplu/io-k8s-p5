package IO::K8s::AgentSandbox::V1beta1::SandboxWarmPoolSpec;
# ABSTRACT: SandboxWarmPoolSpec
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s replicas           => Int, { minimum => 0, default => 1 };
k8s sandboxTemplateRef => '+IO::K8s::AgentSandbox::V1beta1::SandboxTemplateRef', { required => 'schema' };
k8s updateStrategy     => '+IO::K8s::AgentSandbox::V1beta1::SandboxWarmPoolUpdateStrategy';

=attr replicas

No description in the upstream schema.

=cut

=attr sandboxTemplateRef

No description in the upstream schema.

=cut

=attr updateStrategy

No description in the upstream schema.

=cut

1;
