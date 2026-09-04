package IO::K8s::PrometheusOperator::V1::RuleGroup;
# ABSTRACT: RuleGroup is a list of sequentially evaluated recording and alerting rules.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s interval                  => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s labels                    => { Str => 1 };
k8s limit                     => Int;
k8s name                      => Str, { required => 'schema' };
k8s partial_response_strategy => Str, { pattern => qr/^(?i)(abort|warn)?$/i };
k8s query_offset              => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s rules                     => ['+IO::K8s::PrometheusOperator::V1::Rule'];

=attr interval

interval defines how often rules in the group are evaluated.

=cut

=attr labels

labels define the labels to add or overwrite before storing the result for its rules.
The labels defined at the rule level take precedence.

It requires Prometheus >= 3.0.0.
The field is ignored for Thanos Ruler.

=cut

=attr limit

limit defines the number of alerts an alerting rule and series a recording
rule can produce.
Limit is supported starting with Prometheus >= 2.31 and Thanos Ruler >= 0.24.

=cut

=attr name

name defines the name of the rule group.

=cut

=attr partial_response_strategy

partial_response_strategy is only used by ThanosRuler and will
be ignored by Prometheus instances.
More info: https://github.com/thanos-io/thanos/blob/main/docs/components/rule.md#partial-response

=cut

=attr query_offset

query_offset defines the offset the rule evaluation timestamp of this particular group by the specified duration into the past.

It requires Prometheus >= v2.53.0.
It is not supported for ThanosRuler.

=cut

=attr rules

rules defines the list of alerting and recording rules.

=cut

1;
