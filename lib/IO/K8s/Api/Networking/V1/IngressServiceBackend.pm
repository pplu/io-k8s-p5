package IO::K8s::Api::Networking::V1::IngressServiceBackend;
# ABSTRACT: IngressServiceBackend references a Kubernetes Service as a Backend.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

name is the referenced service. The service must exist in the same namespace as the Ingress object.

=cut

k8s port => 'Networking::V1::ServiceBackendPort';

=attr port

port of the referenced service. A port name or port number is required for a IngressServiceBackend.

=cut

1;
