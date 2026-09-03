package IO::K8s::Traefik;
# ABSTRACT: Traefik CRD resource map provider for IO::K8s
our $VERSION = '1.108';
use Moo;
with 'IO::K8s::Role::ResourceMap';

sub upstream_version { 'v3.7.12' }  # traefik/traefik (CRD set stable across all v3.x)

# Upstream CRD manifests for the pinned upstream_version, consumed by
# maint/crd-drift-check.pl. Data only -- no fetching here. The per-Kind
# reference CRDs (one CustomResourceDefinition per file) live under
# docs/content/reference/dynamic-configuration; `base` + each `files`
# entry is the raw manifest URL, cached under spec/crd/Traefik/.
sub crd_sources {
    my $v = __PACKAGE__->upstream_version;
    return {
        status => 'ok',
        base   => "https://raw.githubusercontent.com/traefik/traefik/$v/docs/content/reference/dynamic-configuration",
        files  => [
            'traefik.io_ingressroutes.yaml',
            'traefik.io_ingressroutetcps.yaml',
            'traefik.io_ingressrouteudps.yaml',
            'traefik.io_middlewares.yaml',
            'traefik.io_middlewaretcps.yaml',
            'traefik.io_serverstransports.yaml',
            'traefik.io_serverstransporttcps.yaml',
            'traefik.io_tlsoptions.yaml',
            'traefik.io_tlsstores.yaml',
            'traefik.io_traefikservices.yaml',
        ],
    };
}

sub resource_map {
    return {
        IngressRoute        => 'Traefik::V1alpha1::IngressRoute',
        IngressRouteTCP     => 'Traefik::V1alpha1::IngressRouteTCP',
        IngressRouteUDP     => 'Traefik::V1alpha1::IngressRouteUDP',
        Middleware          => 'Traefik::V1alpha1::Middleware',
        MiddlewareTCP       => 'Traefik::V1alpha1::MiddlewareTCP',
        ServersTransport    => 'Traefik::V1alpha1::ServersTransport',
        ServersTransportTCP => 'Traefik::V1alpha1::ServersTransportTCP',
        TLSOption           => 'Traefik::V1alpha1::TLSOption',
        TLSStore            => 'Traefik::V1alpha1::TLSStore',
        TraefikService      => 'Traefik::V1alpha1::TraefikService',
    };
}

1;

__END__

=head1 SYNOPSIS

    my $k8s = IO::K8s->new(with => ['IO::K8s::Traefik']);

    my $ir = $k8s->new_object('IngressRoute',
        metadata => { name => 'my-route', namespace => 'default' },
        spec => {
            entryPoints => ['web'],
            routes => [{ match => 'Host(`example.com`)', kind => 'Rule' }],
        },
    );

    print $ir->to_yaml;

=head1 DESCRIPTION

Resource map provider for L<Traefik|https://traefik.io/> Custom Resource
Definitions. Registers 10 CRD classes for C<traefik.io/v1alpha1>, modeled to
full depth: C<spec> (and, where upstream declares one, C<status>) is a typed
object graph of 76 further C<IO::K8s::Traefik::V1alpha1::*> classes, one per
upstream Go structure, named after the upstream Go types
(L<IO::K8s::Traefik::V1alpha1::Middleware|IO::K8s::Traefik::V1alpha1::Middleware>'s
C<rateLimit> is an C<IO::K8s::Traefik::V1alpha1::RateLimit>, and so on down)
rather than an opaque hashref. Embedded core types are referenced, not
re-modeled — a route's C<middlewares>/C<parentRefs> are
L<Core::V1::SecretReference|IO::K8s::Api::Core::V1::SecretReference>. A Go
type used by more than one Kind (C<Service>, C<Sticky>, C<Cookie>,
C<ServerHealthCheck>, C<IPStrategy>, ...) is one shared class, not a copy per
Kind.

Not loaded by default — opt in via the C<with> constructor parameter of
L<IO::K8s> or by calling C<< $k8s->add('IO::K8s::Traefik') >> at runtime.

=head2 Included CRDs (traefik.io/v1alpha1)

IngressRoute, IngressRouteTCP, IngressRouteUDP, Middleware, MiddlewareTCP,
ServersTransport, ServersTransportTCP, TLSOption, TLSStore, TraefikService

All resources are namespace-scoped.

=seealso

L<IO::K8s>

L<Traefik documentation|https://doc.traefik.io/traefik/>

L<Traefik Kubernetes CRD reference|https://doc.traefik.io/traefik/routing/providers/kubernetes-crd/>

=cut
