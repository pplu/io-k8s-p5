package IO::K8s::Cilium::V2::PortRule;
# ABSTRACT: PortRule is a list of ports/protocol combinations with optional Layer 7 rules which must be met.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s listener       => '+IO::K8s::Cilium::V2::Listener';
k8s originatingTLS => '+IO::K8s::Cilium::V2::TLSContext';
k8s ports          => ['Networking::V1::NetworkPolicyPort'];
k8s rules          => '+IO::K8s::Cilium::V2::L7Rules';
k8s serverNames    => [Str], { pattern => qr/^([-a-zA-Z0-9_*]+[.]?)+$/ };
k8s terminatingTLS => '+IO::K8s::Cilium::V2::TLSContext';

=attr listener

listener specifies the name of a custom Envoy listener to which this traffic should be
redirected to.

=cut

=attr originatingTLS

OriginatingTLS is the TLS context for the connections originated by
the L7 proxy.  For egress policy this specifies the client-side TLS
parameters for the upstream connection originating from the L7 proxy
to the remote destination. For ingress policy this specifies the
client-side TLS parameters for the connection from the L7 proxy to
the local endpoint.

=cut

=attr ports

Ports is a list of L4 port/protocol

=cut

=attr rules

Rules is a list of additional port level rules which must be met in
order for the PortRule to allow the traffic. If omitted or empty,
no layer 7 rules are enforced.

=cut

=attr serverNames

ServerNames is a list of allowed TLS SNI values. If not empty, then
TLS must be present and one of the provided SNIs must be indicated in the
TLS handshake.

=cut

=attr terminatingTLS

TerminatingTLS is the TLS context for the connection terminated by
the L7 proxy.  For egress policy this specifies the server-side TLS
parameters to be applied on the connections originated from the local
endpoint and terminated by the L7 proxy. For ingress policy this specifies
the server-side TLS parameters to be applied on the connections
originated from a remote source and terminated by the L7 proxy.

=cut

1;
