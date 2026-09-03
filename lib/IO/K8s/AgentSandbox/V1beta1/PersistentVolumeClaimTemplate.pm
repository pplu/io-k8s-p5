package IO::K8s::AgentSandbox::V1beta1::PersistentVolumeClaimTemplate;
# ABSTRACT: PersistentVolumeClaimTemplate
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s metadata => '+IO::K8s::AgentSandbox::V1beta1::EmbeddedObjectMetadata';
k8s spec     => 'Core::V1::PersistentVolumeClaimSpec', { required => 'schema' };

=attr metadata

No description in the upstream schema.

=cut

=attr spec

No description in the upstream schema.

=cut

1;
