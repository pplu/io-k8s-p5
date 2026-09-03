package IO::K8s::AgentSandbox::V1beta1::SandboxSpec;
# ABSTRACT: SandboxSpec
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s operatingMode        => Str, { enum => [qw(Running Suspended)], default => 'Running' };
k8s podTemplate          => '+IO::K8s::AgentSandbox::V1beta1::PodTemplate', { required => 'schema' };
k8s service              => Bool;
k8s shutdownPolicy       => Str, { enum => [qw(Delete Retain)], default => 'Retain' };
k8s shutdownTime         => Time;
k8s volumeClaimTemplates => ['+IO::K8s::AgentSandbox::V1beta1::PersistentVolumeClaimTemplate'];

=attr operatingMode

No description in the upstream schema.

=cut

=attr podTemplate

No description in the upstream schema.

=cut

=attr service

No description in the upstream schema.

=cut

=attr shutdownPolicy

No description in the upstream schema.

=cut

=attr shutdownTime

No description in the upstream schema.

=cut

=attr volumeClaimTemplates

No description in the upstream schema.

=cut

1;
