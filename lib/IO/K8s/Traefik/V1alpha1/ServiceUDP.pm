package IO::K8s::Traefik::V1alpha1::ServiceUDP;
# ABSTRACT: ServiceUDP defines an upstream UDP service to proxy traffic to.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name       => Str, { required => 'schema' };
k8s namespace  => Str;
k8s nativeLB   => Bool;
k8s nodePortLB => Bool;
k8s port       => IntOrStr, { required => 'schema' };
k8s weight     => Int, { minimum => 0 };

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

=attr weight

Weight defines the weight used when balancing requests between multiple Kubernetes Service.

=cut

1;
