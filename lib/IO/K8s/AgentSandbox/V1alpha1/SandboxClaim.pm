package IO::K8s::AgentSandbox::V1alpha1::SandboxClaim;
# ABSTRACT: Request for sandbox allocation
our $VERSION = '1.011';
use IO::K8s::APIObject
    api_version     => 'extensions.agents.x-k8s.io/v1alpha1',
    resource_plural => 'sandboxclaims';
with 'IO::K8s::Role::Namespaced';

k8s spec => {
    sandboxTemplateRef => {
        name => Str,
    },
    lifecycle => {
        shutdownTime   => Time,
        shutdownPolicy => Str,
    },
};
k8s status => {
    conditions => { Str => 1 },
    sandbox    => {
        Name => Str,
    },
};

1;

__END__

=head1 DESCRIPTION

SandboxClaim requests allocation of a sandbox instance by referencing a SandboxTemplate.
This is a namespace-scoped resource using API version C<extensions.agents.x-k8s.io/v1alpha1>.
The C<spec> and C<status> fields are typed inline structs generated from the upstream
AgentSandbox Go types.

=seealso

=over

=item * L<IO::K8s::AgentSandbox>

=item * L<https://github.com/kubernetes-sigs/agent-sandbox>

=back

=cut
