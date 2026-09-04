package IO::K8s::PrometheusOperator::V1::WorkloadBinding;
# ABSTRACT: WorkloadBinding is a link between a configuration resource and a workload resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conditions => ['Meta::V1::Condition'];
k8s group      => Str, { required => 'schema', enum => [qw(monitoring.coreos.com)] };
k8s name       => Str, { required => 'schema' };
k8s namespace  => Str, { required => 'schema' };
k8s resource   => Str, { required => 'schema', enum => [qw(prometheuses prometheusagents thanosrulers alertmanagers)] };

=attr conditions

conditions defines the current state of the configuration resource when bound to the referenced Workload object.

=cut

=attr group

group defines the group of the referenced resource.

=cut

=attr name

name defines the name of the referenced object.

=cut

=attr namespace

namespace defines the namespace of the referenced object.

=cut

=attr resource

resource defines the type of resource being referenced (e.g. Prometheus, PrometheusAgent, ThanosRuler or Alertmanager).

=cut

1;
