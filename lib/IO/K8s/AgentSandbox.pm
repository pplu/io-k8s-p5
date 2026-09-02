package IO::K8s::AgentSandbox;
# ABSTRACT: AgentSandbox CRD resource map provider for IO::K8s
our $VERSION = '1.108';
use Moo;
with 'IO::K8s::Role::ResourceMap';

sub upstream_version { 'v1.0.0' }  # kubernetes-sigs/agent-sandbox

# Upstream CRD manifests for the pinned upstream_version, consumed by
# maint/crd-drift-check.pl. Data only -- no fetching here. The canonical
# CRD bases live under k8s/crds; `base` + each `files` entry is the raw
# manifest URL, cached under spec/crd/AgentSandbox/.
sub crd_sources {
    my $v = __PACKAGE__->upstream_version;
    return {
        status => 'ok',
        base   => "https://raw.githubusercontent.com/kubernetes-sigs/agent-sandbox/$v/k8s/crds",
        files  => [
            'agents.x-k8s.io_sandboxes.yaml',
            'extensions.agents.x-k8s.io_sandboxclaims.yaml',
            'extensions.agents.x-k8s.io_sandboxtemplates.yaml',
            'extensions.agents.x-k8s.io_sandboxwarmpools.yaml',
        ],
    };
}

sub resource_map {
    return {
        # agents.x-k8s.io/v1beta1 (storage version)
        Sandbox         => 'AgentSandbox::V1beta1::Sandbox',
        # extensions.agents.x-k8s.io/v1beta1 (storage version)
        SandboxClaim    => 'AgentSandbox::V1beta1::SandboxClaim',
        SandboxTemplate => 'AgentSandbox::V1beta1::SandboxTemplate',
        SandboxWarmPool => 'AgentSandbox::V1beta1::SandboxWarmPool',
        # v1alpha1 was served through the v0.5.x line and was REMOVED upstream
        # at v1.0.0; these classes are kept here as back-compat for clusters
        # still on agent-sandbox v0.5.x. The short names above stay on v1beta1
        # (now the only upstream-served version) and the older track is
        # reachable through these domain-qualified keys only (k58, k88). The
        # matching v1beta1 qualified keys need no literal entry here:
        # IO::K8s::add() derives them from each mapped class's own
        # api_version().
        'agents.x-k8s.io/v1alpha1/Sandbox'                    => 'AgentSandbox::V1alpha1::Sandbox',
        'extensions.agents.x-k8s.io/v1alpha1/SandboxClaim'    => 'AgentSandbox::V1alpha1::SandboxClaim',
        'extensions.agents.x-k8s.io/v1alpha1/SandboxTemplate' => 'AgentSandbox::V1alpha1::SandboxTemplate',
        'extensions.agents.x-k8s.io/v1alpha1/SandboxWarmPool' => 'AgentSandbox::V1alpha1::SandboxWarmPool',
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
Custom Resource Definitions, matching upstream AgentSandbox v1.0.0. Registers 4 short
names covering 4 CRD kinds:

=over 4

=item * C<agents.x-k8s.io>: Sandbox (main API group)

=item * C<extensions.agents.x-k8s.io>: SandboxClaim, SandboxTemplate, SandboxWarmPool

=back

Each kind ships two API versions on disk — C<v1alpha1> (served through the v0.5.x
line and B<removed upstream at v1.0.0>) and C<v1beta1> (the current, and now only,
upstream-served version). The C<v1alpha1> classes are B<kept here as back-compat> for
clusters still on agent-sandbox v0.5.x. The short-name C<resource_map> below resolves
to the C<v1beta1> class for each kind; the C<v1alpha1> classes remain available for
direct use by their full class name (C<IO::K8s::AgentSandbox::V1alpha1::*>) or via
domain-qualified lookup (e.g. C<agents.x-k8s.io/v1alpha1/Sandbox>).

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
