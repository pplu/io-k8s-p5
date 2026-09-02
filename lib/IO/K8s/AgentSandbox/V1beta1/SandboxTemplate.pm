package IO::K8s::AgentSandbox::V1beta1::SandboxTemplate;
# ABSTRACT: Reusable sandbox configuration template
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'extensions.agents.x-k8s.io/v1beta1',
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
version C<extensions.agents.x-k8s.io/v1beta1>, the storage version as of upstream
AgentSandbox v0.5.4. The C<spec> field is a typed inline struct generated from the
upstream AgentSandbox Go types. There is no C<status> object for this kind, in either
API version.

Compared to the deprecated (served-but-not-storage) C<extensions.agents.x-k8s.io/v1alpha1>
track modeled by L<IO::K8s::AgentSandbox::V1alpha1::SandboxTemplate>, this version's
C<spec> shares C<envVarsInjectionPolicy>, C<service>, and C<volumeClaimTemplates> with
that track, and additionally carries C<volumeClaimTemplatesPolicy>, which is present only
here and absent from the C<v1alpha1> CRD schema.

=seealso

=over

=item * L<IO::K8s::AgentSandbox>

=item * L<IO::K8s::AgentSandbox::V1alpha1::SandboxTemplate>

=item * L<https://github.com/kubernetes-sigs/agent-sandbox>

=back

=cut
