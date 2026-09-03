package IO::K8s::Cilium::V2::RedirectBackend;
# ABSTRACT: RedirectBackend specifies backend configuration to redirect traffic to.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s localEndpointSelector => 'Meta::V1::LabelSelector', { required => 'schema' };
k8s toPorts               => ['+IO::K8s::Cilium::V2::PortInfo'], { required => 'schema' };

=attr localEndpointSelector

LocalEndpointSelector selects node local pod(s) where traffic is redirected to.

=cut

=attr toPorts

ToPorts is a list of L4 ports with protocol of node local pod(s) where traffic
is redirected to.
When multiple ports are specified, the ports must be named.

=cut

1;
