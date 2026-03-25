package IO::K8s::AgentSandbox::V1alpha1::SandboxTemplate;
# ABSTRACT: Reusable sandbox configuration template
our $VERSION = '1.011';
use IO::K8s::APIObject
    api_version     => 'extensions.agents.x-k8s.io/v1alpha1',
    resource_plural => 'sandboxtemplates';
with 'IO::K8s::Role::Namespaced';

k8s spec => {
    podTemplate             => { Str => 1 },
    networkPolicy           => { Str => 1 },
    networkPolicyManagement => Str,
};

1;

__END__

=head1 DESCRIPTION

SandboxTemplate defines a reusable configuration for sandbox instances, including a pod
template and optional network policy. This is a namespace-scoped resource using API
version C<extensions.agents.x-k8s.io/v1alpha1>. The C<spec> field is a typed inline
struct generated from the upstream AgentSandbox Go types.

=seealso

=over

=item * L<IO::K8s::AgentSandbox>

=item * L<https://github.com/kubernetes-sigs/agent-sandbox>

=back

=cut
