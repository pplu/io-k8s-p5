package IO::K8s::AgentSandbox::V1alpha1::SandboxClaim;
# ABSTRACT: Request for sandbox allocation
our $VERSION = '1.105';
use IO::K8s::APIObject
    api_version     => 'extensions.agents.x-k8s.io/v1alpha1',
    resource_plural => 'sandboxclaims';
with 'IO::K8s::Role::Namespaced';

k8s spec => {
    sandboxTemplateRef => {
        name => Str,
    },
    warmpool => Str,
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

SandboxClaim requests allocation of a sandbox instance by referencing a SandboxTemplate
(C<spec.sandboxTemplateRef>) or a warm pool (C<spec.warmpool>).
This is a namespace-scoped resource using API version C<extensions.agents.x-k8s.io/v1alpha1>.
The C<spec> and C<status> fields are typed inline structs generated from the upstream
AgentSandbox Go types.

As of upstream AgentSandbox v0.5.4, this API version is still served but is no longer
the storage version — C<extensions.agents.x-k8s.io/v1beta1> (see
L<IO::K8s::AgentSandbox::V1beta1::SandboxClaim>) is now canonical and drops
C<spec.sandboxTemplateRef> in favor of a required C<spec.warmPoolRef>. This C<v1alpha1>
track has gained C<spec.additionalPodMetadata>, C<spec.env>,
C<spec.lifecycle.ttlSecondsAfterFinished>, and C<status.sandbox.podIPs>, and
C<status.sandbox.name> is now lowercase (previously C<status.sandbox.Name>).

=seealso

=over

=item * L<IO::K8s::AgentSandbox>

=item * L<IO::K8s::AgentSandbox::V1beta1::SandboxClaim>

=item * L<https://github.com/kubernetes-sigs/agent-sandbox>

=back

=cut
