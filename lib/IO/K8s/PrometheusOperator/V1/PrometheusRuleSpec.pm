package IO::K8s::PrometheusOperator::V1::PrometheusRuleSpec;
# ABSTRACT: spec defines the specification of desired alerting rule definitions for Prometheus.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s groups => ['+IO::K8s::PrometheusOperator::V1::RuleGroup'];

=attr groups

groups defines the content of Prometheus rule file

=cut

1;
