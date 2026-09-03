package IO::K8s::K3s::V1::HelmChart;
# ABSTRACT: HelmChart represents configuration and state for the deployment of a Helm chart.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'helm.cattle.io/v1',
    resource_plural => 'helmcharts';
with 'IO::K8s::Role::Namespaced', 'IO::K8s::Role::HelmManaged';

k8s spec   => '+IO::K8s::K3s::V1::HelmChartSpec', { required => 'schema' };
k8s status => '+IO::K8s::K3s::V1::HelmChartStatus';

=attr spec

HelmChartSpec represents the user-configurable details for installation and upgrade of a Helm chart release.

=cut

=attr status

HelmChartStatus represents the resulting state from processing HelmChart events

=cut

1;
