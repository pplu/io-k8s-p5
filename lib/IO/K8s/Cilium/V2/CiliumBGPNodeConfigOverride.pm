package IO::K8s::Cilium::V2::CiliumBGPNodeConfigOverride;
# ABSTRACT: CiliumBGPNodeConfigOverride specifies configuration overrides for a CiliumBGPNodeConfig.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumbgpnodeconfigoverrides';

k8s spec => '+IO::K8s::Cilium::V2::CiliumBGPNodeConfigOverrideSpec', { required => 'schema' };

=attr spec

Spec is the specification of the desired behavior of the CiliumBGPNodeConfigOverride.

=cut

1;
