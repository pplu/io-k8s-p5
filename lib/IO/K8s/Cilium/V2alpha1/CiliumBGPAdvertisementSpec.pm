package IO::K8s::Cilium::V2alpha1::CiliumBGPAdvertisementSpec;
# ABSTRACT: CiliumBGPAdvertisementSpec
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s advertisements => ['+IO::K8s::Cilium::V2alpha1::BGPAdvertisement'], { required => 'schema' };

=attr advertisements

Advertisements is a list of BGP advertisements.

=cut

1;
