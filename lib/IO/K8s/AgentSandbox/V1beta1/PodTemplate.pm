package IO::K8s::AgentSandbox::V1beta1::PodTemplate;
# ABSTRACT: PodTemplate
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s metadata => '+IO::K8s::AgentSandbox::V1beta1::PodMetadata';
k8s spec     => '+IO::K8s::AgentSandbox::V1beta1::PodSpec', { required => 'schema' };

=attr metadata

No description in the upstream schema.

=cut

=attr spec

No description in the upstream schema.

=cut

1;
