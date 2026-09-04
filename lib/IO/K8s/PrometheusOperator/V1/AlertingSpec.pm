package IO::K8s::PrometheusOperator::V1::AlertingSpec;
# ABSTRACT: alerting defines the settings related to Alertmanager.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s alertmanagers => ['+IO::K8s::PrometheusOperator::V1::AlertmanagerEndpoints'], { required => 'schema' };

=attr alertmanagers

alertmanagers endpoints where Prometheus should send alerts to.

=cut

1;
