package IO::K8s::Cilium::V2::ServiceInfo;
# ABSTRACT: ServiceMatcher specifies Kubernetes service and port that matches traffic to be redirected.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s namespace   => Str, { required => 'schema' };
k8s serviceName => Str, { required => 'schema' };
k8s toPorts     => ['+IO::K8s::Cilium::V2::PortInfo'];

=attr namespace

Namespace is the Kubernetes service namespace.
The service namespace must match the namespace of the parent Local
Redirect Policy.  For Cluster-wide Local Redirect Policy, this
can be any namespace.

=cut

=attr serviceName

Name is the name of a destination Kubernetes service that identifies traffic
to be redirected.
The service type needs to be ClusterIP.

Example:
When this field is populated with 'serviceName:myService', all the traffic
destined to the cluster IP of this service at the (specified)
service port(s) will be redirected.

=cut

=attr toPorts

ToPorts is a list of destination service L4 ports with protocol for
traffic to be redirected. If not specified, traffic for all the service
ports will be redirected.
When multiple ports are specified, the ports must be named.

=cut

1;
