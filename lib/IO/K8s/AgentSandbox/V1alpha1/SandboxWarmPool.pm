package IO::K8s::AgentSandbox::V1alpha1::SandboxWarmPool;
# ABSTRACT: Pre-warmed pool of sandbox instances
our $VERSION = '1.106';
use IO::K8s::APIObject
    api_version     => 'extensions.agents.x-k8s.io/v1alpha1',
    resource_plural => 'sandboxwarmpools';
with 'IO::K8s::Role::Namespaced';

k8s spec => {
    replicas     => Int,
    sandboxTemplateRef => {
        name => Str,
    },
    updateStrategy => {
        type => Str,
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

As of upstream AgentSandbox v0.5.4, this API version is still served but is no longer
the storage version — C<extensions.agents.x-k8s.io/v1beta1> (see
L<IO::K8s::AgentSandbox::V1beta1::SandboxWarmPool>) is now canonical. This C<v1alpha1>
track has gained C<spec.updateStrategy.type> (C<Recreate> or C<OnReplenish>) — the
same addition made to the C<v1beta1> track.

=seealso

=over

=item * L<IO::K8s::AgentSandbox>

=item * L<IO::K8s::AgentSandbox::V1beta1::SandboxWarmPool>

=item * L<https://github.com/kubernetes-sigs/agent-sandbox>

=back

=cut
