package IO::K8s::AgentSandbox;
# ABSTRACT: AgentSandbox CRD resource map provider for IO::K8s
our $VERSION = '1.105';
use Moo;
with 'IO::K8s::Role::ResourceMap';

sub upstream_version { 'v0.5.4' }  # kubernetes-sigs/agent-sandbox

sub resource_map {
    return {
        # agents.x-k8s.io/v1beta1 (storage version)
        Sandbox         => 'AgentSandbox::V1beta1::Sandbox',
        # extensions.agents.x-k8s.io/v1beta1 (storage version)
        SandboxClaim    => 'AgentSandbox::V1beta1::SandboxClaim',
        SandboxTemplate => 'AgentSandbox::V1beta1::SandboxTemplate',
        SandboxWarmPool => 'AgentSandbox::V1beta1::SandboxWarmPool',
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
Custom Resource Definitions, matching upstream AgentSandbox v0.5.4. Registers 4 short
names covering 4 CRD kinds:

=over 4

=item * C<agents.x-k8s.io>: Sandbox (main API group)

=item * C<extensions.agents.x-k8s.io>: SandboxClaim, SandboxTemplate, SandboxWarmPool

=back

Each kind ships two API versions on disk — C<v1alpha1> (still served, but deprecated
and no longer the storage version as of v0.5.4) and C<v1beta1> (the current storage
version). The short-name C<resource_map> below resolves to the C<v1beta1> class for
each kind; the C<v1alpha1> classes remain available for direct use by their full class
name (C<IO::K8s::AgentSandbox::V1alpha1::*>) or via domain-qualified lookup (e.g.
C<agents.x-k8s.io/v1alpha1/Sandbox>).

AgentSandbox manages isolated, stateful, singleton workloads for AI agent runtimes.

Not loaded by default — opt in via the C<with> constructor parameter of
L<IO::K8s> or by calling C<< $k8s->add('IO::K8s::AgentSandbox') >> at runtime.

=head2 Included CRDs (agents.x-k8s.io/v1beta1, agents.x-k8s.io/v1alpha1)

Sandbox

=head2 Included CRDs (extensions.agents.x-k8s.io/v1beta1, extensions.agents.x-k8s.io/v1alpha1)

SandboxClaim, SandboxTemplate, SandboxWarmPool

=seealso

L<IO::K8s>

L<AgentSandbox repository|https://github.com/kubernetes-sigs/agent-sandbox>

=cut
