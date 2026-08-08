package IO::K8s::AgentSandbox::V1alpha1::SandboxTemplate;
# ABSTRACT: Reusable sandbox configuration template
our $VERSION = '1.101';
use IO::K8s::APIObject
    api_version     => 'extensions.agents.x-k8s.io/v1alpha1',
    resource_plural => 'sandboxtemplates';
with 'IO::K8s::Role::Namespaced';

k8s spec => {
    podTemplate                => { Str => 1 },
    networkPolicy               => { Str => 1 },
    networkPolicyManagement     => Str,
    envVarsInjectionPolicy      => Str,
    service                     => Bool,
    volumeClaimTemplates        => ['Core::V1::PersistentVolumeClaim'],
    volumeClaimTemplatesPolicy  => Str,
};

1;

__END__

=head1 DESCRIPTION

SandboxTemplate defines a reusable configuration for sandbox instances, including a pod
template and optional network policy. This is a namespace-scoped resource using API
version C<extensions.agents.x-k8s.io/v1alpha1>. The C<spec> field is a typed inline
struct generated from the upstream AgentSandbox Go types. There is no C<status> object
for this kind.

As of upstream AgentSandbox v0.5.4, this API version is still served but is no longer
the storage version — C<extensions.agents.x-k8s.io/v1beta1> (see
L<IO::K8s::AgentSandbox::V1beta1::SandboxTemplate>) is now canonical. This C<v1alpha1>
track has gained C<spec.envVarsInjectionPolicy>, C<spec.service>,
C<spec.volumeClaimTemplates>, and C<spec.volumeClaimTemplatesPolicy> — the same
additions made to the C<v1beta1> track.

=seealso

=over

=item * L<IO::K8s::AgentSandbox>

=item * L<IO::K8s::AgentSandbox::V1beta1::SandboxTemplate>

=item * L<https://github.com/kubernetes-sigs/agent-sandbox>

=back

=cut
