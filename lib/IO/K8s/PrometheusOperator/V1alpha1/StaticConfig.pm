package IO::K8s::PrometheusOperator::V1alpha1::StaticConfig;
# ABSTRACT: StaticConfig defines a Prometheus static configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s labels  => { Str => 1 };
k8s targets => [Str], { required => 'schema' };

=attr labels

labels defines labels assigned to all metrics scraped from the targets.

=cut

=attr targets

targets defines the list of targets for this static configuration.

=cut

1;
