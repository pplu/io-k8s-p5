package IO::K8s::AgentSandbox::V1beta1::Sandbox;
# ABSTRACT: Sandbox
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'agents.x-k8s.io/v1beta1',
    resource_plural => 'sandboxes';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::AgentSandbox::V1beta1::SandboxSpec', { required => 'schema' };
k8s status => '+IO::K8s::AgentSandbox::V1beta1::SandboxStatus';

=attr spec

No description in the upstream schema.

=cut

=attr status

No description in the upstream schema.

=cut

1;
