package IO::K8s::Cilium;
# ABSTRACT: Cilium CRD resource map provider for IO::K8s
our $VERSION = '1.001';
use Moo;
with 'IO::K8s::Role::ResourceMap';

sub resource_map {
    return {
        # cilium.io/v2
        CiliumNetworkPolicy            => 'Cilium::V2::CiliumNetworkPolicy',
        CiliumClusterwideNetworkPolicy => 'Cilium::V2::CiliumClusterwideNetworkPolicy',
        CiliumLocalRedirectPolicy      => 'Cilium::V2::CiliumLocalRedirectPolicy',
        CiliumEgressGatewayPolicy      => 'Cilium::V2::CiliumEgressGatewayPolicy',
        CiliumIdentity                 => 'Cilium::V2::CiliumIdentity',
        CiliumEndpoint                 => 'Cilium::V2::CiliumEndpoint',
        CiliumNode                     => 'Cilium::V2::CiliumNode',
        CiliumNodeConfig               => 'Cilium::V2::CiliumNodeConfig',
        CiliumLoadBalancerIPPool       => 'Cilium::V2::CiliumLoadBalancerIPPool',
        CiliumEnvoyConfig              => 'Cilium::V2::CiliumEnvoyConfig',
        CiliumClusterwideEnvoyConfig   => 'Cilium::V2::CiliumClusterwideEnvoyConfig',
        CiliumExternalWorkload         => 'Cilium::V2::CiliumExternalWorkload',
        # cilium.io/v2alpha1
        CiliumEndpointSlice            => 'Cilium::V2alpha1::CiliumEndpointSlice',
        CiliumL2AnnouncementPolicy     => 'Cilium::V2alpha1::CiliumL2AnnouncementPolicy',
        CiliumBGPPeeringPolicy         => 'Cilium::V2alpha1::CiliumBGPPeeringPolicy',
        CiliumBGPClusterConfig         => 'Cilium::V2alpha1::CiliumBGPClusterConfig',
        CiliumBGPPeerConfig            => 'Cilium::V2alpha1::CiliumBGPPeerConfig',
        CiliumBGPAdvertisement         => 'Cilium::V2alpha1::CiliumBGPAdvertisement',
        CiliumBGPNodeConfig            => 'Cilium::V2alpha1::CiliumBGPNodeConfig',
        CiliumBGPNodeConfigOverride    => 'Cilium::V2alpha1::CiliumBGPNodeConfigOverride',
        CiliumGatewayClassConfig       => 'Cilium::V2alpha1::CiliumGatewayClassConfig',
        CiliumCIDRGroup                => 'Cilium::V2alpha1::CiliumCIDRGroup',
        CiliumPodIPPool                => 'Cilium::V2alpha1::CiliumPodIPPool',
    };
}

1;
