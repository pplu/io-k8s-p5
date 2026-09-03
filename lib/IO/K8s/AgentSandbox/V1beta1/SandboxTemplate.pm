package IO::K8s::AgentSandbox::V1beta1::SandboxTemplate;
# ABSTRACT: SandboxTemplate
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'extensions.agents.x-k8s.io/v1beta1',
    resource_plural => 'sandboxtemplates';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::AgentSandbox::V1beta1::SandboxTemplateSpec', { required => 'schema' };

=attr spec

No description in the upstream schema.

=cut

1;
