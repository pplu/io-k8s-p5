package IO::K8s::Cilium;
# ABSTRACT: Cilium CRD resource map provider for IO::K8s
our $VERSION = '1.003';
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

__END__

=head1 SYNOPSIS

    my $k8s = IO::K8s->new(with => ['IO::K8s::Cilium']);

    my $cnp = $k8s->new_object('CiliumNetworkPolicy',
        metadata => { name => 'allow-dns', namespace => 'kube-system' },
        spec => { endpointSelector => {} },
    );

    print $cnp->to_yaml;

=head1 DESCRIPTION

Resource map provider for L<Cilium|https://cilium.io/> Custom Resource
Definitions. Registers 23 CRD classes covering C<cilium.io/v2> and
C<cilium.io/v2alpha1>.

Not loaded by default — opt in via the C<with> constructor parameter of
L<IO::K8s> or by calling C<< $k8s->add('IO::K8s::Cilium') >> at runtime.

=head2 Included CRDs (cilium.io/v2)

CiliumNetworkPolicy, CiliumClusterwideNetworkPolicy,
CiliumLocalRedirectPolicy, CiliumEgressGatewayPolicy, CiliumIdentity,
CiliumEndpoint, CiliumNode, CiliumNodeConfig, CiliumLoadBalancerIPPool,
CiliumEnvoyConfig, CiliumClusterwideEnvoyConfig, CiliumExternalWorkload

=head2 Included CRDs (cilium.io/v2alpha1)

CiliumEndpointSlice, CiliumL2AnnouncementPolicy, CiliumBGPPeeringPolicy,
CiliumBGPClusterConfig, CiliumBGPPeerConfig, CiliumBGPAdvertisement,
CiliumBGPNodeConfig, CiliumBGPNodeConfigOverride, CiliumGatewayClassConfig,
CiliumCIDRGroup, CiliumPodIPPool

=seealso

L<IO::K8s>

L<Cilium documentation|https://docs.cilium.io/>

L<Cilium CRD reference|https://docs.cilium.io/en/stable/network/kubernetes/policy/>

=cut
