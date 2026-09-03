package IO::K8s::AgentSandbox::V1beta1::SandboxTemplateSpec;
# ABSTRACT: SandboxTemplateSpec
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s envVarsInjectionPolicy     => Str, { enum => [qw(Allowed Overrides Disallowed)], default => 'Disallowed' };
k8s networkPolicy              => '+IO::K8s::AgentSandbox::V1beta1::NetworkPolicySpec';
k8s networkPolicyManagement    => Str, { enum => [qw(Managed Unmanaged)], default => 'Managed' };
k8s podTemplate                => '+IO::K8s::AgentSandbox::V1beta1::PodTemplate', { required => 'schema' };
k8s service                    => Bool;
k8s volumeClaimTemplates       => ['+IO::K8s::AgentSandbox::V1beta1::PersistentVolumeClaimTemplate'];
k8s volumeClaimTemplatesPolicy => Str, { enum => [qw(Disallowed Allowed Overrides)], default => 'Disallowed' };

=attr envVarsInjectionPolicy

No description in the upstream schema.

=cut

=attr networkPolicy

No description in the upstream schema.

=cut

=attr networkPolicyManagement

No description in the upstream schema.

=cut

=attr podTemplate

No description in the upstream schema.

=cut

=attr service

No description in the upstream schema.

=cut

=attr volumeClaimTemplates

No description in the upstream schema.

=cut

=attr volumeClaimTemplatesPolicy

No description in the upstream schema.

=cut

1;
