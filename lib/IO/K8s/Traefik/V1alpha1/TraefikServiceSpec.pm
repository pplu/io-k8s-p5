package IO::K8s::Traefik::V1alpha1::TraefikServiceSpec;
# ABSTRACT: TraefikServiceSpec defines the desired state of a TraefikService.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s failover            => '+IO::K8s::Traefik::V1alpha1::Failover';
k8s highestRandomWeight => '+IO::K8s::Traefik::V1alpha1::HighestRandomWeight';
k8s mirroring           => '+IO::K8s::Traefik::V1alpha1::Mirroring';
k8s weighted            => '+IO::K8s::Traefik::V1alpha1::WeightedRoundRobin';

=attr failover

Failover defines the Failover service configuration.

=cut

=attr highestRandomWeight

HighestRandomWeight defines the highest random weight service configuration.

=cut

=attr mirroring

Mirroring defines the Mirroring service configuration.

=cut

=attr weighted

Weighted defines the Weighted Round Robin configuration.

=cut

1;
