package IO::K8s::Api::Autoscaling::V1::ScaleStatus;
# ABSTRACT: ScaleStatus represents the current status of a scale subresource.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s replicas => Int, 'required';

=attr replicas

replicas is the actual number of observed instances of the scaled object.

=cut

k8s selector => Str;

=attr selector

selector is the label query over pods that should match the replicas count. This is same as the label selector but in the string format to avoid introspection by clients. The string will be in the same format as the query-param syntax. More info about label selectors: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/

=cut

1;
