package IO::K8s::PrometheusOperator::V1::ObjectReference;
# ABSTRACT: ObjectReference references a PodMonitor, ServiceMonitor, Probe or PrometheusRule object.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s group     => Str, { enum => [qw(monitoring.coreos.com)], default => 'monitoring.coreos.com' };
k8s name      => Str;
k8s namespace => Str, { required => 'schema' };
k8s resource  => Str, { required => 'schema', enum => [qw(prometheusrules servicemonitors podmonitors probes scrapeconfigs)] };

=attr group

group of the referent. When not specified, it defaults to `monitoring.coreos.com`

=cut

=attr name

name of the referent. When not set, all resources in the namespace are matched.

=cut

=attr namespace

namespace of the referent.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/

=cut

=attr resource

resource of the referent.

=cut

1;
