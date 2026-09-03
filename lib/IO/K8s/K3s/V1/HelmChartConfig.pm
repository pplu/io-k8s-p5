package IO::K8s::K3s::V1::HelmChartConfig;
# ABSTRACT: HelmChartConfig represents additional configuration for the installation of Helm chart release.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'helm.cattle.io/v1',
    resource_plural => 'helmchartconfigs';
with 'IO::K8s::Role::Namespaced', 'IO::K8s::Role::HelmManaged';

k8s spec => '+IO::K8s::K3s::V1::HelmChartConfigSpec', { required => 'schema' };

=attr spec

HelmChartConfigSpec represents additional user-configurable details of an installed and configured Helm chart release. These fields are merged with or override the corresponding fields on the related HelmChart resource.

=cut

1;
