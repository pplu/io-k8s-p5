package IO::K8s::Traefik::V1alpha1::HighestRandomWeight;
# ABSTRACT: HighestRandomWeight defines the highest random weight service configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s services => ['+IO::K8s::Traefik::V1alpha1::Service'];

=attr services

Services defines the list of Kubernetes Service and/or TraefikService to load-balance, with weight.

=cut

1;
