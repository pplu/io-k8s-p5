package IO::K8s::K3s::V1::HelmChart;
# ABSTRACT: K3s Helm chart deployment
our $VERSION = '1.003';
use IO::K8s::APIObject
    api_version     => 'helm.cattle.io/v1',
    resource_plural => 'helmcharts';
with 'IO::K8s::Role::Namespaced', 'IO::K8s::Role::HelmManaged';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This class represents a HelmChart custom resource in the C<helm.cattle.io/v1> API group. HelmChart resources declare Helm charts to be deployed by the K3s Helm controller, which automatically manages the chart lifecycle. This is a namespace-scoped resource where the C<spec> and C<status> fields are opaque hash structures defined by the K3s API.

=seealso

=over

=item * L<IO::K8s::K3s> - K3s custom resources

=item * L<https://docs.k3s.io/helm> - K3s Helm Controller Documentation

=back

=cut
