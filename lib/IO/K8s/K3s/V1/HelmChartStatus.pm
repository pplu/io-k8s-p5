package IO::K8s::K3s::V1::HelmChartStatus;
# ABSTRACT: HelmChartStatus represents the resulting state from processing HelmChart events
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conditions => ['+IO::K8s::K3s::V1::HelmChartCondition'];
k8s jobName    => Str;

=attr conditions

`JobCreated` indicates that a job has been created to install or upgrade the chart.
`Failed` indicates that the helm job has failed and the failure policy is set to `abort`.

=cut

=attr jobName

The name of the job created to install or upgrade the chart.

=cut

1;
