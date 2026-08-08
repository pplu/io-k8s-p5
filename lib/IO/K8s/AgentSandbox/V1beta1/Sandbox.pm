package IO::K8s::AgentSandbox::V1beta1::Sandbox;
# ABSTRACT: Isolated runtime environment for AI agents
our $VERSION = '1.106';
use IO::K8s::APIObject
    api_version     => 'agents.x-k8s.io/v1beta1',
    resource_plural => 'sandboxes';
with 'IO::K8s::Role::Namespaced';

k8s spec => {
    podTemplate           => { Str => 1 },
    volumeClaimTemplates  => { Str => 1 },
    shutdownTime          => Time,
    shutdownPolicy        => Str,
    operatingMode         => Str,
    service               => Bool,
};
k8s status => {
    serviceFQDN => Str,
    service     => Str,
    conditions  => { Str => 1 },
    selector    => Str,
    nodeName    => Str,
    podIPs      => [Str],
};

1;

__END__

=head1 DESCRIPTION

Sandbox is an isolated runtime environment for AI agents. It provides a stateful,
singleton workload scheduled on Kubernetes nodes. This is a namespace-scoped resource
using API version C<agents.x-k8s.io/v1beta1>, the storage version as of upstream
AgentSandbox v0.5.4. The C<spec> and C<status> fields are typed inline structs
generated from the upstream AgentSandbox Go types.

Unlike the deprecated (served-but-not-storage) C<agents.x-k8s.io/v1alpha1> track
modeled by L<IO::K8s::AgentSandbox::V1alpha1::Sandbox>, this version drops
C<spec.replicas> and C<status.replicas> entirely. Lifecycle is instead controlled
via C<spec.operatingMode> (C<Running> or C<Suspended>), and C<status.nodeName> /
C<status.podIPs> report pod placement directly.

=seealso

=over

=item * L<IO::K8s::AgentSandbox>

=item * L<IO::K8s::AgentSandbox::V1alpha1::Sandbox>

=item * L<https://github.com/kubernetes-sigs/agent-sandbox>

=back

=cut
