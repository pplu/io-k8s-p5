package IO::K8s::PrometheusOperator::V1alpha1::K8SSelectorConfig;
# ABSTRACT: K8SSelectorConfig is Kubernetes Selector Config
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s field => Str;
k8s label => Str;
k8s role  => Str, { required => 'schema', enum => [qw(Pod Endpoints Ingress Service Node EndpointSlice)] };

=attr field

field defines an optional field selector to limit the service discovery to resources which have fields with specific values.
e.g: `metadata.name=foobar`

=cut

=attr label

label defines an optional label selector to limit the service discovery to resources with specific labels and label values.
e.g: `node.kubernetes.io/instance-type=master`

=cut

=attr role

role defines the type of Kubernetes resource to limit the service discovery to.
Accepted values are: Node, Pod, Endpoints, EndpointSlice, Service, Ingress.

=cut

1;
