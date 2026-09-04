package IO::K8s::PrometheusOperator::V1::Rule;
# ABSTRACT: Rule describes an alerting or recording rule See Prometheus documentation: [alerting](https://www.prometheus.io/docs/prometheus/latest/configuration/alerting_rules/) or [recording](https://www.prometheus.io/docs/prometheus/latest/configuration/recording_rules/#recording-rules) rule
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s alert           => Str;
k8s annotations     => { Str => 1 };
k8s expr            => IntOrStr, { required => 'schema' };
k8s for             => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s keep_firing_for => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s labels          => { Str => 1 };
k8s record          => Str;

=attr alert

alert defines the name of the alert. Must be a valid label value.
Only one of `record` and `alert` must be set.

=cut

=attr annotations

annotations defines annotations to add to each alert.
Only valid for alerting rules.

=cut

=attr expr

expr defines the PromQL expression to evaluate.

=cut

=attr for

for defines how alerts are considered firing once they have been returned for this long.

=cut

=attr keep_firing_for

keep_firing_for defines how long an alert will continue firing after the condition that triggered it has cleared.

=cut

=attr labels

labels defines labels to add or overwrite.

=cut

=attr record

record defines the name of the time series to output to. Must be a valid metric name.
Only one of `record` and `alert` must be set.

=cut

1;
