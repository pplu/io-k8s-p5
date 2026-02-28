package IO::K8s::Api::Autoscaling::V2::ContainerResourceMetricStatus;
# ABSTRACT: ContainerResourceMetricStatus indicates the current value of a resource metric known to Kubernetes, as specified in requests and limits, describing a single container in each pod in the current scale target (e.g. CPU or memory).  Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the "pods" source.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s container => Str, 'required';

=attr container

container is the name of the container in the pods of the scaling target

=cut

k8s current => 'Autoscaling::V2::MetricValueStatus', 'required';

=attr current

current contains the current value for the given metric

=cut

k8s name => Str, 'required';

=attr name

name is the name of the resource in question.

=cut

1;
