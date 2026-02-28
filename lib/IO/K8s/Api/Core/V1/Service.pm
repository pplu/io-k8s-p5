package IO::K8s::Api::Core::V1::Service;
# ABSTRACT: Service is a named abstraction of software service (for example, mysql) consisting of local port (for example 3306) that the proxy listens on, and the selector that determines which pods will answer requests sent through the proxy.
our $VERSION = '1.004';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

Service is a named abstraction of software service (for example, mysql) consisting of local port (for example 3306) that the proxy listens on, and the selector that determines which pods will answer requests sent through the proxy.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Core::V1::ServiceSpec';

=attr spec

Spec defines the behavior of a service. https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status


=cut

k8s status => 'Core::V1::ServiceStatus';

=attr status

Most recently observed status of the service. Populated by the system. Read-only. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status


=cut

=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#service-v1-core>


=cut

1;
