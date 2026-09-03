package IO::K8s::Traefik::V1alpha1::WeightedRoundRobin;
# ABSTRACT: Weighted defines the Weighted Round Robin configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s services => ['+IO::K8s::Traefik::V1alpha1::Service'];
k8s sticky   => '+IO::K8s::Traefik::V1alpha1::Sticky';

=attr services

Services defines the list of Kubernetes Service and/or TraefikService to load-balance, with weight.

=cut

=attr sticky

Sticky defines whether sticky sessions are enabled.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/kubernetes/crd/http/traefikservice/#stickiness-and-load-balancing

=cut

1;
