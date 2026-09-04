package IO::K8s::PrometheusOperator::V1::Alertmanager;
# ABSTRACT: The `Alertmanager` custom resource definition (CRD) defines a desired [Alertmanager](https://prometheus.io/docs/alerting) setup to run in a Kubernetes cluster.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'monitoring.coreos.com/v1',
    resource_plural => 'alertmanagers';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::PrometheusOperator::V1::AlertmanagerSpec', { required => 'schema' };
k8s status => '+IO::K8s::PrometheusOperator::V1::AlertmanagerStatus';

=attr spec

spec defines the specification of the desired behavior of the Alertmanager cluster. More info:
https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

=attr status

status defines the most recent observed status of the Alertmanager cluster. Read-only.
More info:
https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

1;
