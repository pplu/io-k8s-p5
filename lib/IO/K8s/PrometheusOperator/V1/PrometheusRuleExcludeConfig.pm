package IO::K8s::PrometheusOperator::V1::PrometheusRuleExcludeConfig;
# ABSTRACT: PrometheusRuleExcludeConfig enables users to configure excluded PrometheusRule names and their namespaces to be ignored while enforcing namespace label for alerts and metrics.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s ruleName      => Str, { required => 'schema' };
k8s ruleNamespace => Str, { required => 'schema' };

=attr ruleName

ruleName defines the name of the excluded PrometheusRule object.

=cut

=attr ruleNamespace

ruleNamespace defines the namespace of the excluded PrometheusRule object.

=cut

1;
