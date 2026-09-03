package IO::K8s::Traefik::V1alpha1::ServiceTCP;
# ABSTRACT: ServiceTCP defines an upstream TCP service to proxy traffic to.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name             => Str, { required => 'schema' };
k8s namespace        => Str;
k8s nativeLB         => Bool;
k8s nodePortLB       => Bool;
k8s port             => IntOrStr, { required => 'schema' };
k8s proxyProtocol    => '+IO::K8s::Traefik::V1alpha1::ProxyProtocol';
k8s serversTransport => Str;
k8s terminationDelay => Int;
k8s tls              => Bool;
k8s weight           => Int, { minimum => 0 };

=attr name

Name defines the name of the referenced Kubernetes Service.

=cut

=attr namespace

Namespace defines the namespace of the referenced Kubernetes Service.

=cut

=attr nativeLB

NativeLB controls, when creating the load-balancer,
whether the LB's children are directly the pods IPs or if the only child is the Kubernetes Service clusterIP.
The Kubernetes Service itself does load-balance to the pods.
By default, NativeLB is false.

=cut

=attr nodePortLB

NodePortLB controls, when creating the load-balancer,
whether the LB's children are directly the nodes internal IPs using the nodePort when the service type is NodePort.
It allows services to be reachable when Traefik runs externally from the Kubernetes cluster but within the same network of the nodes.
By default, NodePortLB is false.

=cut

=attr port

Port defines the port of a Kubernetes Service.
This can be a reference to a named port.

=cut

=attr proxyProtocol

ProxyProtocol defines the PROXY protocol configuration.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/tcp/service/#proxy-protocol

Deprecated: ProxyProtocol will not be supported in future APIVersions, please use ServersTransport to configure ProxyProtocol instead.

=cut

=attr serversTransport

ServersTransport defines the name of ServersTransportTCP resource to use.
It allows to configure the transport between Traefik and your servers.
Can only be used on a Kubernetes Service.

=cut

=attr terminationDelay

TerminationDelay defines the deadline that the proxy sets, after one of its connected peers indicates
it has closed the writing capability of its connection, to close the reading capability as well,
hence fully terminating the connection.
It is a duration in milliseconds, defaulting to 100.
A negative value means an infinite deadline (i.e. the reading capability is never closed).

Deprecated: TerminationDelay will not be supported in future APIVersions, please use ServersTransport to configure the TerminationDelay instead.

=cut

=attr tls

TLS determines whether to use TLS when dialing with the backend.

=cut

=attr weight

Weight defines the weight used when balancing requests between multiple Kubernetes Service.

=cut

1;
