package IO::K8s::Cilium::V2::CiliumEnvoyConfigSpec;
# ABSTRACT: CiliumEnvoyConfigSpec
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s backendServices => ['+IO::K8s::Cilium::V2::EnvoyConfigService'];
k8s nodeSelector    => 'Meta::V1::LabelSelector';
k8s resources       => [ {} ], { required => 'schema' };
k8s services        => ['+IO::K8s::Cilium::V2::ServiceListener'];

=attr backendServices

BackendServices specifies Kubernetes services whose backends
are automatically synced to Envoy using EDS.  Traffic for these
services is not forwarded to an Envoy listener. This allows an
Envoy listener load balance traffic to these backends while
normal Cilium service load balancing takes care of balancing
traffic for these services at the same time.

=cut

=attr nodeSelector

NodeSelector is a label selector that determines to which nodes
this configuration applies.
If nil, then this config applies to all nodes.

=cut

=attr resources

Envoy xDS resources, a list of the following Envoy resource types:
type.googleapis.com/envoy.config.listener.v3.Listener,
type.googleapis.com/envoy.config.route.v3.RouteConfiguration,
type.googleapis.com/envoy.config.cluster.v3.Cluster,
type.googleapis.com/envoy.config.endpoint.v3.ClusterLoadAssignment, and
type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.Secret.

=cut

=attr services

Services specifies Kubernetes services for which traffic is
forwarded to an Envoy listener for L7 load balancing. Backends
of these services are automatically synced to Envoy usign EDS.

=cut

1;
