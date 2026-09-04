package IO::K8s::PrometheusOperator::V1::Rules;
# ABSTRACT: rules defines the configuration of the Prometheus rules' engine.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s alert => '+IO::K8s::PrometheusOperator::V1::RulesAlert';

=attr alert

alert defines the parameters of the Prometheus rules' engine.

Any update to these parameters trigger a restart of the pods.

=cut

1;
