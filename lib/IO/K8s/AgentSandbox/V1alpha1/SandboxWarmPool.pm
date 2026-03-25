package IO::K8s::AgentSandbox::V1alpha1::SandboxWarmPool;
# ABSTRACT: Pre-warmed pool of sandbox instances
our $VERSION = '1.011';
use IO::K8s::APIObject
    api_version     => 'extensions.agents.x-k8s.io/v1alpha1',
    resource_plural => 'sandboxwarmpools';
with 'IO::K8s::Role::Namespaced';

k8s spec => {
    replicas     => Int,
    sandboxTemplateRef => {
        name => Str,
    },
};
k8s status => {
    replicas      => Int,
    readyReplicas => Int,
    selector      => Str,
};

1;

__END__

=head1 DESCRIPTION

SandboxWarmPool manages a pool of pre-warmed Sandbox instances for quick allocation,
reducing startup latency. This is a namespace-scoped resource using API version
C<extensions.agents.x-k8s.io/v1alpha1>. The C<spec> and C<status> fields are typed
inline structs generated from the upstream AgentSandbox Go types.

=seealso

=over

=item * L<IO::K8s::AgentSandbox>

=item * L<https://github.com/kubernetes-sigs/agent-sandbox>

=back

=cut
