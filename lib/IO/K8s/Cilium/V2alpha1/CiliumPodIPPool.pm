package IO::K8s::Cilium::V2alpha1::CiliumPodIPPool;
# ABSTRACT: CiliumPodIPPool defines an IP pool that can be used for pooled IPAM (i.e.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliumpodippools';

k8s spec => '+IO::K8s::Cilium::V2alpha1::IPPoolSpec', { required => 'schema' };

=attr spec

No description in the upstream schema.

=cut

1;
