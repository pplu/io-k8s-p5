package IO::K8s::AgentSandbox::V1alpha1::Sandbox;
# ABSTRACT: Isolated runtime environment for AI agents
our $VERSION = '1.011';
use IO::K8s::APIObject
    api_version     => 'agents.x-k8s.io/v1alpha1',
    resource_plural => 'sandboxes';
with 'IO::K8s::Role::Namespaced';

k8s spec => {
    podTemplate           => { Str => 1 },
    volumeClaimTemplates  => { Str => 1 },
    shutdownTime          => Time,
    shutdownPolicy        => Str,
    replicas              => Int,
};
k8s status => {
    serviceFQDN => Str,
    service     => Str,
    conditions  => { Str => 1 },
    replicas    => Int,
    selector    => Str,
};

1;

__END__

=head1 DESCRIPTION

Sandbox is an isolated runtime environment for AI agents. It provides a stateful,
singleton workload scheduled on Kubernetes nodes. This is a namespace-scoped resource
using API version C<agents.x-k8s.io/v1alpha1>. The C<spec> and C<status> fields are
typed inline structs generated from the upstream AgentSandbox Go types.

=seealso

=over

=item * L<IO::K8s::AgentSandbox>

=item * L<https://github.com/kubernetes-sigs/agent-sandbox>

=back

=cut
