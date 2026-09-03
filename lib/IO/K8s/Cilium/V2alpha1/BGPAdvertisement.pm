package IO::K8s::Cilium::V2alpha1::BGPAdvertisement;
# ABSTRACT: BGPAdvertisement defines which routes Cilium should advertise to BGP peers.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s advertisementType => Str, { required => 'schema', enum => [qw(PodCIDR CiliumPodIPPool Service)] };
k8s attributes        => '+IO::K8s::Cilium::V2alpha1::BGPAttributes';
k8s selector          => 'Meta::V1::LabelSelector';
k8s service           => '+IO::K8s::Cilium::V2alpha1::BGPServiceOptions';

=attr advertisementType

AdvertisementType defines type of advertisement which has to be advertised.

=cut

=attr attributes

Attributes defines additional attributes to set to the advertised routes.
If not specified, no additional attributes are set.

=cut

=attr selector

Selector is a label selector to select objects of the type specified by AdvertisementType.
For the PodCIDR AdvertisementType it is not applicable. For other advertisement types,
if not specified, no objects of the type specified by AdvertisementType are selected for advertisement.

=cut

=attr service

Service defines configuration options for advertisementType service.

=cut

1;
