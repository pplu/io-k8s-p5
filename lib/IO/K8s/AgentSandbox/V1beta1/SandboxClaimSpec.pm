package IO::K8s::AgentSandbox::V1beta1::SandboxClaimSpec;
# ABSTRACT: SandboxClaimSpec
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s additionalPodMetadata => '+IO::K8s::AgentSandbox::V1beta1::PodMetadata';
k8s env                   => ['+IO::K8s::AgentSandbox::V1beta1::EnvVar'];
k8s lifecycle             => '+IO::K8s::AgentSandbox::V1beta1::Lifecycle';
k8s volumeClaimTemplates  => ['+IO::K8s::AgentSandbox::V1beta1::PersistentVolumeClaimTemplate'];
k8s warmPoolRef           => '+IO::K8s::AgentSandbox::V1beta1::SandboxWarmPoolRef', { required => 'schema' };

=attr additionalPodMetadata

No description in the upstream schema.

=cut

=attr env

No description in the upstream schema.

=cut

=attr lifecycle

No description in the upstream schema.

=cut

=attr volumeClaimTemplates

No description in the upstream schema.

=cut

=attr warmPoolRef

No description in the upstream schema.

=cut

1;
