package IO::K8s::Api::Networking::V1::IngressBackend;
# ABSTRACT: IngressBackend describes all endpoints for a given service and port.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s resource => 'Core::V1::TypedLocalObjectReference';

=attr resource

resource is an ObjectRef to another Kubernetes resource in the namespace of the Ingress object. If resource is specified, a service.Name and service.Port must not be specified. This is a mutually exclusive setting with "Service".

=cut

k8s service => 'Networking::V1::IngressServiceBackend';

=attr service

service references a service as a backend. This is a mutually exclusive setting with "Resource".

=cut

1;
