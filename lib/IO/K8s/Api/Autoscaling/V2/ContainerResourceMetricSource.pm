package IO::K8s::Api::Autoscaling::V2::ContainerResourceMetricSource;
# ABSTRACT: ContainerResourceMetricSource indicates how to scale on a resource metric known to Kubernetes, as specified in requests and limits, describing each pod in the current scale target (e.g. CPU or memory).  The values will be averaged together before being compared to the target.  Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the "pods" source.  Only one "target" type should be set.

use IO::K8s::Resource;

k8s container => Str, 'required';

=attr container

container is the name of the container in the pods of the scaling target

=cut

k8s name => Str, 'required';

=attr name

name is the name of the resource in question.

=cut

k8s target => 'Autoscaling::V2::MetricTarget', 'required';

=attr target

target specifies the target value for the given metric

=cut

1;
