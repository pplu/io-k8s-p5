package IO::K8s::PrometheusOperator::V1::RulesAlert;
# ABSTRACT: alert defines the parameters of the Prometheus rules' engine.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s forGracePeriod     => Str;
k8s forOutageTolerance => Str;
k8s resendDelay        => Str;

=attr forGracePeriod

forGracePeriod defines the minimum duration between alert and restored 'for' state.

This is maintained only for alerts with a configured 'for' time greater
than the grace period.

=cut

=attr forOutageTolerance

forOutageTolerance defines the max time to tolerate prometheus outage for restoring 'for' state of
alert.

=cut

=attr resendDelay

resendDelay defines the minimum amount of time to wait before resending an alert to
Alertmanager.

=cut

1;
