package IO::K8s::GatewayAPI::V1::UDPRouteRule;
# ABSTRACT: UDPRouteRule is the configuration for a given rule.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s backendRefs => ['+IO::K8s::GatewayAPI::V1::BackendRef'], { required => 'schema' };
k8s name        => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };

=attr backendRefs

BackendRefs defines the backend(s) where matching requests should be
sent. If unspecified or invalid (refers to a nonexistent resource or a
Service with no endpoints), the underlying implementation MUST actively
reject connection attempts to this backend. Packet drops must
respect weight; if an invalid backend is requested to have 80% of
the packets, then 80% of packets must be dropped instead.

Support: Extended for Kubernetes Service

=cut

=attr name

Name is the name of the route rule. This name MUST be unique within a Route if it is set.

=cut

1;
