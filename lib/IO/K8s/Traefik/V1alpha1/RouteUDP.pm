package IO::K8s::Traefik::V1alpha1::RouteUDP;
# ABSTRACT: RouteUDP holds the UDP route configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s services => ['+IO::K8s::Traefik::V1alpha1::ServiceUDP'];

=attr services

Services defines the list of UDP services.

=cut

1;
