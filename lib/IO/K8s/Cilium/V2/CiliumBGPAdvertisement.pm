package IO::K8s::Cilium::V2::CiliumBGPAdvertisement;
# ABSTRACT: CiliumBGPAdvertisement is the Schema for the ciliumbgpadvertisements API
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumbgpadvertisements';

k8s spec => '+IO::K8s::Cilium::V2::CiliumBGPAdvertisementSpec', { required => 'schema' };

=attr spec

No description in the upstream schema.

=cut

1;
