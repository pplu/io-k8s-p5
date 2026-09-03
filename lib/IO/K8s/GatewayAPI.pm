package IO::K8s::GatewayAPI;
# ABSTRACT: Gateway API CRD resource map provider for IO::K8s
our $VERSION = '1.108';
use Moo;
with 'IO::K8s::Role::ResourceMap';

sub upstream_version { 'v1.6.1' }  # kubernetes-sigs/gateway-api (GA/Standard channel only)

# Upstream CRD manifests for the pinned upstream_version, consumed by
# maint/crd-drift-check.pl. Data only -- no fetching here. GA/Standard
# channel only (config/crd/standard), matching this provider's scope; the
# experimental channel is deliberately not tracked. `base` + each `files`
# entry is the raw manifest URL, cached under spec/crd/GatewayAPI/.
sub crd_sources {
    my $v = __PACKAGE__->upstream_version;
    return {
        status => 'ok',
        base   => "https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/$v/config/crd/standard",
        files  => [
            'gateway.networking.k8s.io_backendtlspolicies.yaml',
            'gateway.networking.k8s.io_gatewayclasses.yaml',
            'gateway.networking.k8s.io_gateways.yaml',
            'gateway.networking.k8s.io_grpcroutes.yaml',
            'gateway.networking.k8s.io_httproutes.yaml',
            'gateway.networking.k8s.io_listenersets.yaml',
            'gateway.networking.k8s.io_referencegrants.yaml',
            'gateway.networking.k8s.io_tcproutes.yaml',
            'gateway.networking.k8s.io_tlsroutes.yaml',
            'gateway.networking.k8s.io_udproutes.yaml',
        ],
    };
}

sub resource_map {
    return {
        # gateway.networking.k8s.io/v1 -- the storage version of every Kind
        # except ReferenceGrant; short names resolve here (D7).
        GatewayClass     => 'GatewayAPI::V1::GatewayClass',
        Gateway          => 'GatewayAPI::V1::Gateway',
        HTTPRoute        => 'GatewayAPI::V1::HTTPRoute',
        GRPCRoute        => 'GatewayAPI::V1::GRPCRoute',
        BackendTLSPolicy => 'GatewayAPI::V1::BackendTLSPolicy',
        ListenerSet      => 'GatewayAPI::V1::ListenerSet',
        TLSRoute         => 'GatewayAPI::V1::TLSRoute',
        TCPRoute         => 'GatewayAPI::V1::TCPRoute',
        UDPRoute         => 'GatewayAPI::V1::UDPRoute',
        # ReferenceGrant is served at both v1 and v1beta1 as of v1.5.0; v1beta1
        # remains the storage version as of v1.6.1, so it keeps the short name.
        # The v1 class is reachable via its domain-qualified key below.
        'gateway.networking.k8s.io/v1/ReferenceGrant' => 'GatewayAPI::V1::ReferenceGrant',

        # gateway.networking.k8s.io/v1beta1 -- Gateway, GatewayClass and
        # HTTPRoute are also served here (served: true, storage: false in
        # the upstream CRD manifest at v1.6.1): older, deprecated tracks of
        # Kinds whose storage version is v1 (D7 -- every served version gets
        # a class). Reachable only by their domain-qualified keys, since the
        # short name resolves to each Kind's storage version above.
        ReferenceGrant   => 'GatewayAPI::V1beta1::ReferenceGrant',
        'gateway.networking.k8s.io/v1beta1/Gateway'      => 'GatewayAPI::V1beta1::Gateway',
        'gateway.networking.k8s.io/v1beta1/GatewayClass' => 'GatewayAPI::V1beta1::GatewayClass',
        'gateway.networking.k8s.io/v1beta1/HTTPRoute'    => 'GatewayAPI::V1beta1::HTTPRoute',
    };
}

1;

__END__

=head1 SYNOPSIS

    my $k8s = IO::K8s->new(with => ['IO::K8s::GatewayAPI']);

    my $gw = $k8s->new_object('Gateway',
        metadata => { name => 'my-gateway', namespace => 'default' },
        spec => {
            gatewayClassName => 'istio',
            listeners => [{ name => 'http', port => 80, protocol => 'HTTP' }],
        },
    );

    print $gw->to_yaml;

=head1 DESCRIPTION

Resource map provider for the L<Kubernetes Gateway API|https://gateway-api.sigs.k8s.io/>
Custom Resource Definitions, modeled to full depth (D5/D6): C<spec> and
C<status> are typed field-by-field, nested classes carry their upstream Go
type names, and embedded core types (C<LabelSelector>-shaped structs, ...)
are referenced rather than re-modeled. 143 classes across 14 GVKs: 10 Kinds
at C<gateway.networking.k8s.io/v1> (GA/Standard channel) and, per D7, every
Kind upstream also serves at C<gateway.networking.k8s.io/v1beta1> --
Gateway, GatewayClass, HTTPRoute and ReferenceGrant.

The Gateway API is an official Kubernetes SIG-Network project that provides
expressive, extensible, and role-oriented interfaces for service networking.

Not loaded by default — opt in via the C<with> constructor parameter of
L<IO::K8s> or by calling C<< $k8s->add('IO::K8s::GatewayAPI') >> at runtime.

=head2 Included CRDs (gateway.networking.k8s.io/v1)

GatewayClass (cluster-scoped), Gateway (namespaced), HTTPRoute (namespaced),
GRPCRoute (namespaced), BackendTLSPolicy (namespaced), ListenerSet
(namespaced), TLSRoute (namespaced), TCPRoute (namespaced), UDPRoute
(namespaced), ReferenceGrant (namespaced; reachable only via the
domain-qualified name C<gateway.networking.k8s.io/v1/ReferenceGrant> since
the short name C<ReferenceGrant> resolves to the v1beta1 storage version) --
these are the storage version of every Kind except ReferenceGrant, so every
short name except C<ReferenceGrant> resolves here

=head2 Included CRDs (gateway.networking.k8s.io/v1beta1)

ReferenceGrant (namespaced) - the storage version; the short name
C<ReferenceGrant> resolves here. Gateway, GatewayClass and HTTPRoute
(namespaced) are also served at v1beta1 upstream but v1 is their storage
version, so these three are reachable only via their domain-qualified names
(C<gateway.networking.k8s.io/v1beta1/Gateway>,
C<gateway.networking.k8s.io/v1beta1/GatewayClass>,
C<gateway.networking.k8s.io/v1beta1/HTTPRoute>).

=seealso

L<IO::K8s>

L<Gateway API documentation|https://gateway-api.sigs.k8s.io/>

L<Gateway API reference|https://gateway-api.sigs.k8s.io/reference/spec/>

L<GatewayClass|https://gateway-api.sigs.k8s.io/api-types/gatewayclass/>

L<HTTPRoute|https://gateway-api.sigs.k8s.io/api-types/httproute/>

L<BackendTLSPolicy|https://gateway-api.sigs.k8s.io/api-types/backendtlspolicy/>

L<ListenerSet|https://gateway-api.sigs.k8s.io/api-types/listenerset/>

L<TLSRoute|https://gateway-api.sigs.k8s.io/api-types/tlsroute/>

L<TCPRoute|https://gateway-api.sigs.k8s.io/api-types/tcproute/>

L<UDPRoute|https://gateway-api.sigs.k8s.io/api-types/udproute/>

=cut
