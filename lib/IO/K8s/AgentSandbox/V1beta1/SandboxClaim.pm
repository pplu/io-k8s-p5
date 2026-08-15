package IO::K8s::AgentSandbox::V1beta1::SandboxClaim;
# ABSTRACT: Request for sandbox allocation from a warm pool
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'extensions.agents.x-k8s.io/v1beta1',
    resource_plural => 'sandboxclaims';
with 'IO::K8s::Role::Namespaced';

k8s spec => {
    additionalPodMetadata => {
        annotations => { Str => 1 },
        labels      => { Str => 1 },
    },
    env => { Str => 1 },
    lifecycle => {
        shutdownTime            => Time,
        shutdownPolicy          => Str,
        ttlSecondsAfterFinished => Int,
    },
    volumeClaimTemplates => ['Core::V1::PersistentVolumeClaim'],
    warmPoolRef => {
        name => Str,
    },
};
k8s status => {
    conditions => { Str => 1 },
    sandbox    => {
        name   => Str,
        podIPs => [Str],
    },
};

1;

__END__

=head1 DESCRIPTION

SandboxClaim requests allocation of a sandbox instance. This is a namespace-scoped
resource using API version C<extensions.agents.x-k8s.io/v1beta1>, the storage
version as of upstream AgentSandbox v0.5.4. The C<spec> and C<status> fields are
typed inline structs generated from the upstream AgentSandbox Go types.

Unlike the deprecated (served-but-not-storage) C<extensions.agents.x-k8s.io/v1alpha1>
track modeled by L<IO::K8s::AgentSandbox::V1alpha1::SandboxClaim>, this version drops
C<spec.sandboxTemplateRef> entirely — a claim is fulfilled by referencing a
L<IO::K8s::AgentSandbox::V1beta1::SandboxWarmPool> via C<spec.warmPoolRef> instead
of a template directly. It also gains C<spec.additionalPodMetadata>, C<spec.env>,
C<spec.lifecycle.ttlSecondsAfterFinished>, and a typed C<spec.volumeClaimTemplates>
list, and C<status.sandbox.name> (lowercase, replacing the C<v1alpha1> track's
C<status.sandbox.Name>) gains a sibling C<status.sandbox.podIPs>.

=seealso

=over

=item * L<IO::K8s::AgentSandbox>

=item * L<IO::K8s::AgentSandbox::V1alpha1::SandboxClaim>

=item * L<IO::K8s::AgentSandbox::V1beta1::SandboxWarmPool>

=item * L<https://github.com/kubernetes-sigs/agent-sandbox>

=back

=cut
