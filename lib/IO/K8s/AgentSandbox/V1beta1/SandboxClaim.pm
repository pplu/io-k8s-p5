package IO::K8s::AgentSandbox::V1beta1::SandboxClaim;
# ABSTRACT: SandboxClaim
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'extensions.agents.x-k8s.io/v1beta1',
    resource_plural => 'sandboxclaims';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::AgentSandbox::V1beta1::SandboxClaimSpec', { required => 'schema' };
k8s status => '+IO::K8s::AgentSandbox::V1beta1::SandboxClaimStatus';

=attr spec

No description in the upstream schema.

=cut

=attr status

No description in the upstream schema.

=cut

1;
