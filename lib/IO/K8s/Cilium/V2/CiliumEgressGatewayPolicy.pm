package IO::K8s::Cilium::V2::CiliumEgressGatewayPolicy;
# ABSTRACT: Cilium egress gateway policy
our $VERSION = '1.003';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumegressgatewaypolicies';
with 'IO::K8s::Role::Namespaced';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This namespace-scoped resource routes pod egress traffic through specific gateway nodes with stable source IPs, enabling external services to whitelist known IP addresses. It uses API version C<cilium.io/v2>. The C<spec> and C<status> fields contain opaque CRD-specific data structures managed by the Cilium controller.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/network/egress-gateway/> - Upstream Cilium egress gateway policy documentation

=back

=cut
