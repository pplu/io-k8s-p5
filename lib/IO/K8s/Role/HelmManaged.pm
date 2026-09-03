package IO::K8s::Role::HelmManaged;
# ABSTRACT: Role for K3s Helm chart management
our $VERSION = '1.108';
use Moo::Role;

=method from_repo

    $chart->from_repo($repo_url, $chart_name);

Sets the chart's C<spec.repo> to C<$repo_url> and C<spec.chart> to
C<$chart_name>, matching the HelmChart CRD's C<spec.chart> + C<spec.repo>
fields under C<helm.cattle.io/v1>. Returns C<$self> for chaining.

    $chart->from_repo('https://traefik.github.io/charts', 'traefik');

=cut

sub from_repo {
    my ($self, $repo_url, $chart_name) = @_;
    $self->spec_set('repo',  $repo_url);
    $self->spec_set('chart', $chart_name);
    return $self;
}

=method set_version

    $chart->set_version($version);

Sets the chart's C<spec.version> -- the Helm chart version to pin against,
not the C<apiVersion> of the CRD. Returns C<$self> for chaining.

    $chart->set_version('25.0.0');

=cut

sub set_version {
    my ($self, $version) = @_;
    $self->spec_set('version', $version);
    return $self;
}

=method set_values

    $chart->set_values(key1 => $value1, key2 => $value2, ...);

Merges the given key/value pairs into the chart's C<spec.set> hash,
preserving any values already present. This is the K3s equivalent of
C<helm install --set key=value ...> and ends up on the wire as the
C<spec.set> block the HelmChart CRD supports. Returns C<$self> for
chaining.

    $chart->set_values(replicas => 3, logLevel => 'info');

=cut

sub set_values {
    my ($self, %values) = @_;
    # Helm keys carry dots (image.tag), so they must not travel through a
    # dotted spec path: fetch the map once and write into it directly.
    my $set = $self->spec_hash('set');
    @{$set}{keys %values} = values %values;
    return $self;
}

=method set_values_yaml

    $chart->set_values_yaml($yaml_str);

Sets the chart's C<spec.valuesContent> to a literal YAML blob. This is the
K3s equivalent of C<helm install --values values.yaml> -- the YAML is
shipped inside the manifest rather than being merged key by key. Returns
C<$self> for chaining.

    $chart->set_values_yaml(<<'YAML');
    replicas: 3
    service:
      type: LoadBalancer
    YAML

=cut

sub set_values_yaml {
    my ($self, $yaml_str) = @_;
    $self->spec_set('valuesContent', $yaml_str);
    return $self;
}

1;

__END__

=head1 SYNOPSIS

    package My::K3s::HelmChart;
    use IO::K8s::APIObject
        api_version     => 'helm.cattle.io/v1',
        resource_plural => 'helmcharts';
    with 'IO::K8s::Role::HelmManaged';

    package main;
    my $k8s = IO::K8s->new(with => ['IO::K8s::K3s']);
    my $chart = $k8s->new_object('HelmChart',
        metadata => { name => 'traefik', namespace => 'kube-system' },
    );
    $chart->from_repo('https://traefik.github.io/charts', 'traefik')
          ->set_version('25.0.0')
          ->set_values(replicas => 3);

=head1 DESCRIPTION

This role provides the fluent setters documented in README's K3s section
for working with C<HelmChart> and C<HelmChartConfig> CRDs from
L<IO::K8s::K3s>. Each setter writes through L<IO::K8s::Role::SpecBuilder>'s
C<spec_*> methods, so the methods work whether the underlying C<spec>
attribute is a plain hash or a typed object.

Use this role on a custom CRD class with
C<api_version =E<gt> 'helm.cattle.io/v1'> or
C<api_version =E<gt> 'k3s.cattle.io/v1'>, or compose it on the bundled
L<IO::K8s::K3s::V1::HelmChart> / L<IO::K8s::K3s::V1::HelmChartConfig>
classes to add the helpers at runtime.

=head1 SEE ALSO

L<IO::K8s::K3s>, L<IO::K8s::Role::SpecBuilder>, L<IO::K8s::APIObject>

=cut