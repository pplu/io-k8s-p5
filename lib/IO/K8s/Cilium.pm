package IO::K8s::Cilium;
# ABSTRACT: Cilium CRD resource map provider for IO::K8s
our $VERSION = '1.108';
use Moo;
with 'IO::K8s::Role::ResourceMap';

sub upstream_version { 'v1.20.1' }  # cilium/cilium

# Upstream CRD manifests for the pinned upstream_version, consumed by
# maint/crd-drift-check.pl. Data only -- no fetching happens here. `base`
# + each `files` entry is the raw manifest URL; the checker caches each
# under spec/crd/Cilium/ (path separators flattened to '_').
sub crd_sources {
    my $v = __PACKAGE__->upstream_version;
    return {
        status => 'ok',
        base   => "https://raw.githubusercontent.com/cilium/cilium/$v/pkg/k8s/apis/cilium.io/client/crds",
        files  => [
            # cilium.io/v2
            'v2/ciliumbgpadvertisements.yaml',
            'v2/ciliumbgpclusterconfigs.yaml',
            'v2/ciliumbgpnodeconfigoverrides.yaml',
            'v2/ciliumbgpnodeconfigs.yaml',
            'v2/ciliumbgppeerconfigs.yaml',
            'v2/ciliumcidrgroups.yaml',
            'v2/ciliumclusterwideenvoyconfigs.yaml',
            'v2/ciliumclusterwidenetworkpolicies.yaml',
            'v2/ciliumegressgatewaypolicies.yaml',
            'v2/ciliumendpoints.yaml',
            'v2/ciliumenvoyconfigs.yaml',
            'v2/ciliumidentities.yaml',
            'v2/ciliumloadbalancerippools.yaml',
            'v2/ciliumlocalredirectpolicies.yaml',
            'v2/ciliumnetworkpolicies.yaml',
            'v2/ciliumnodeconfigs.yaml',
            'v2/ciliumnodes.yaml',
            # cilium.io/v2alpha1
            'v2alpha1/ciliumdatapathplugins.yaml',
            'v2alpha1/ciliumendpointslices.yaml',
            'v2alpha1/ciliumgatewayclassconfigs.yaml',
            'v2alpha1/ciliuml2announcementpolicies.yaml',
            'v2alpha1/ciliumpodippools.yaml',
        ],
    };
}

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
        CiliumCIDRGroup                => 'Cilium::V2::CiliumCIDRGroup',
        CiliumBGPClusterConfig         => 'Cilium::V2::CiliumBGPClusterConfig',
        CiliumBGPPeerConfig            => 'Cilium::V2::CiliumBGPPeerConfig',
        CiliumBGPAdvertisement         => 'Cilium::V2::CiliumBGPAdvertisement',
        CiliumBGPNodeConfig            => 'Cilium::V2::CiliumBGPNodeConfig',
        CiliumBGPNodeConfigOverride    => 'Cilium::V2::CiliumBGPNodeConfigOverride',
        # cilium.io/v2alpha1
        CiliumEndpointSlice            => 'Cilium::V2alpha1::CiliumEndpointSlice',
        CiliumL2AnnouncementPolicy     => 'Cilium::V2alpha1::CiliumL2AnnouncementPolicy',
        CiliumGatewayClassConfig       => 'Cilium::V2alpha1::CiliumGatewayClassConfig',
        CiliumPodIPPool                => 'Cilium::V2alpha1::CiliumPodIPPool',
        CiliumDatapathPlugin           => 'Cilium::V2alpha1::CiliumDatapathPlugin',
        # cilium.io/v2alpha1 back-compat for clusters still on older Cilium
        # releases (k78, k83): the v2alpha1 tracks of BGP/CIDR/LB Kinds were
        # superseded by the matching v2 classes (short names above), and two
        # Kinds were removed (CiliumBGPPeeringPolicy, CiliumExternalWorkload).
        # Each shipped class is reachable only via its domain-qualified key
        # so the short name keeps resolving to the storage version.
        'cilium.io/v2alpha1/CiliumBGPAdvertisement'      => 'Cilium::V2alpha1::CiliumBGPAdvertisement',
        'cilium.io/v2alpha1/CiliumBGPClusterConfig'      => 'Cilium::V2alpha1::CiliumBGPClusterConfig',
        'cilium.io/v2alpha1/CiliumBGPNodeConfig'         => 'Cilium::V2alpha1::CiliumBGPNodeConfig',
        'cilium.io/v2alpha1/CiliumBGPNodeConfigOverride' => 'Cilium::V2alpha1::CiliumBGPNodeConfigOverride',
        'cilium.io/v2alpha1/CiliumBGPPeerConfig'         => 'Cilium::V2alpha1::CiliumBGPPeerConfig',
        'cilium.io/v2alpha1/CiliumCIDRGroup'             => 'Cilium::V2alpha1::CiliumCIDRGroup',
        'cilium.io/v2alpha1/CiliumLoadBalancerIPPool'    => 'Cilium::V2alpha1::CiliumLoadBalancerIPPool',
        'cilium.io/v2alpha1/CiliumBGPPeeringPolicy'      => 'Cilium::V2alpha1::CiliumBGPPeeringPolicy',
        'cilium.io/v2/CiliumExternalWorkload'            => 'Cilium::V2::CiliumExternalWorkload',
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
Definitions. Registers 31 resource_map entries (22 short-name keys plus 9
domain-qualified back-compat keys for v2alpha1 BGP/CIDR/LB tracks and
CiliumExternalWorkload) covering C<cilium.io/v2> and C<cilium.io/v2alpha1>,
matching upstream Cilium v1.20.1.

C<cilium.io/v2> is modeled to full depth: every Kind's C<spec> (and, where
upstream declares one, C<status>) is a typed object graph of further
C<IO::K8s::Cilium::V2::*> classes, one per upstream Go structure, named
after the upstream Go types (L<IO::K8s::Cilium::V2::CiliumNetworkPolicy>'s
C<spec> is an L<IO::K8s::Cilium::V2::Rule>, whose C<egress> is an array of
L<IO::K8s::Cilium::V2::EgressRule>, and so on down) rather than an opaque
hashref — 17 Kinds, 121 further classes. Embedded core types
(C<Meta::V1::LabelSelector>, C<Core::V1::NamespaceCondition>, ...) are
referenced, not re-modeled. C<policy/api.Rule> — the shared policy engine
struct upstream embeds literally the same in both C<CiliumNetworkPolicy> and
C<CiliumClusterwideNetworkPolicy>, at both their C<spec> (one C<Rule>) and
C<specs> (C<Rule[]>) fields — is one shared
L<IO::K8s::Cilium::V2::Rule|IO::K8s::Cilium::V2::Rule> class, not a copy per
Kind. C<CiliumEndpoint> and C<CiliumIdentity> are the two Kinds with no
C<spec> field upstream at all — C<CiliumEndpoint>'s C<status> is still fully
typed (L<IO::K8s::Cilium::V2::EndpointStatus>), C<CiliumIdentity>'s
C<security-labels> is a genuine free-form string map upstream (no per-key
schema to model further).

C<cilium.io/v2alpha1> is modeled to full depth the same way -- 12 Kinds
(the five v2alpha1-only Kinds plus the seven BGP/CIDR/LoadBalancerIPPool
back-compat tracks, which share the very C<kinds.E<lt>KindE<gt>> overlay
entry the C<cilium.io/v2> render of the same Kind uses -- the version
directory alone disambiguates, so a Go type is never accidentally shared
I<across> C<v2>/C<v2alpha1>), under C<IO::K8s::Cilium::V2alpha1::*>.
C<CiliumEndpointSlice> is the third and last Kind with no C<spec> field
upstream; its C<endpoints> is still fully typed
(L<IO::K8s::Cilium::V2alpha1::CoreCiliumEndpoint>).

B<Known issue (karr #108):> L<IO::K8s::Cilium::V2alpha1::AccessLogs>
(nested under C<CiliumGatewayClassConfig>'s
C<spec.telemetry.accessLogs[]>) has a real upstream field literally named
C<json>, which collides with L<IO::K8s::Role::Resource>'s own C<json>
attribute (the shared JSON encoder C<to_json>/C<to_yaml> use internally).
C<to_json>/C<to_yaml> on any C<AccessLogs> instance currently die; every
other field of C<CiliumGatewayClassConfig> is unaffected.

Not loaded by default — opt in via the C<with> constructor parameter of
L<IO::K8s> or by calling C<< $k8s->add('IO::K8s::Cilium') >> at runtime.

=head2 Included CRDs (cilium.io/v2)

CiliumNetworkPolicy, CiliumClusterwideNetworkPolicy,
CiliumLocalRedirectPolicy, CiliumEgressGatewayPolicy, CiliumIdentity,
CiliumEndpoint, CiliumNode, CiliumNodeConfig, CiliumLoadBalancerIPPool,
CiliumEnvoyConfig, CiliumClusterwideEnvoyConfig, CiliumCIDRGroup,
CiliumBGPClusterConfig, CiliumBGPPeerConfig, CiliumBGPAdvertisement,
CiliumBGPNodeConfig, CiliumBGPNodeConfigOverride

=head2 Included CRDs (cilium.io/v2alpha1)

CiliumEndpointSlice, CiliumL2AnnouncementPolicy,
CiliumGatewayClassConfig, CiliumPodIPPool, CiliumDatapathPlugin

=seealso

L<IO::K8s>

L<Cilium documentation|https://docs.cilium.io/>

L<Cilium CRD reference|https://docs.cilium.io/en/stable/network/kubernetes/policy/>

=cut
