package IO::K8s::AgentSandbox;
# ABSTRACT: AgentSandbox CRD resource map provider for IO::K8s
our $VERSION = '1.011';
use Moo;
with 'IO::K8s::Role::ResourceMap';

sub upstream_version { 'v0.2.1' }  # kubernetes-sigs/agent-sandbox

sub resource_map {
    return {
        # agents.x-k8s.io/v1alpha1
        Sandbox         => 'AgentSandbox::V1alpha1::Sandbox',
        # extensions.agents.x-k8s.io/v1alpha1
        SandboxClaim    => 'AgentSandbox::V1alpha1::SandboxClaim',
        SandboxTemplate => 'AgentSandbox::V1alpha1::SandboxTemplate',
        SandboxWarmPool => 'AgentSandbox::V1alpha1::SandboxWarmPool',
    };
}

1;

__END__

=head1 SYNOPSIS

    my $k8s = IO::K8s->new(with => ['IO::K8s::AgentSandbox']);

    my $sandbox = $k8s->new_object('Sandbox',
        metadata => { name => 'my-sandbox', namespace => 'default' },
        spec => { ... },
    );

    print $sandbox->to_yaml;

=head1 DESCRIPTION

Resource map provider for L<AgentSandbox|https://github.com/kubernetes-sigs/agent-sandbox>
Custom Resource Definitions. Registers 4 CRD classes covering:

=over 4

=item * C<agents.x-k8s.io/v1alpha1>: Sandbox (main API group)

=item * C<extensions.agents.x-k8s.io/v1alpha1>: SandboxClaim, SandboxTemplate, SandboxWarmPool

=back

AgentSandbox manages isolated, stateful, singleton workloads for AI agent runtimes.

Not loaded by default — opt in via the C<with> constructor parameter of
L<IO::K8s> or by calling C<< $k8s->add('IO::K8s::AgentSandbox') >> at runtime.

=head2 Included CRDs (agents.x-k8s.io/v1alpha1)

Sandbox

=head2 Included CRDs (extensions.agents.x-k8s.io/v1alpha1)

SandboxClaim, SandboxTemplate, SandboxWarmPool

=seealso

L<IO::K8s>

L<AgentSandbox repository|https://github.com/kubernetes-sigs/agent-sandbox>

=cut
