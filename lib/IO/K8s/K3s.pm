package IO::K8s::K3s;
# ABSTRACT: K3s CRD resource map provider for IO::K8s
our $VERSION = '1.004';
use Moo;
with 'IO::K8s::Role::ResourceMap';

sub resource_map {
    return {
        HelmChart       => 'K3s::V1::HelmChart',
        HelmChartConfig => 'K3s::V1::HelmChartConfig',
        Addon           => 'K3s::V1::Addon',
    };
}

1;

__END__

=head1 SYNOPSIS

    my $k8s = IO::K8s->new(with => ['IO::K8s::K3s']);

    my $hc = $k8s->new_object('HelmChart',
        metadata => { name => 'traefik', namespace => 'kube-system' },
        spec => { chart => 'traefik', version => '25.0.0' },
    );

    print $hc->to_yaml;

=head1 DESCRIPTION

Resource map provider for L<K3s|https://k3s.io/> Custom Resource Definitions.
Registers 3 CRD classes covering C<helm.cattle.io/v1> and C<k3s.cattle.io/v1>.

Not loaded by default — opt in via the C<with> constructor parameter of
L<IO::K8s> or by calling C<< $k8s->add('IO::K8s::K3s') >> at runtime.

=head2 Included CRDs (helm.cattle.io/v1)

HelmChart, HelmChartConfig

=head2 Included CRDs (k3s.cattle.io/v1)

Addon

All resources are namespace-scoped.

=seealso

L<IO::K8s>

L<K3s documentation|https://docs.k3s.io/>

L<K3s Helm integration|https://docs.k3s.io/helm>

L<K3s packaged components|https://docs.k3s.io/installation/packaged-components>

=cut
