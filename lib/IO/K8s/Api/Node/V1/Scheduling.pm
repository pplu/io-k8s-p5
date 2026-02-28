package IO::K8s::Api::Node::V1::Scheduling;
# ABSTRACT: Scheduling specifies the scheduling constraints for nodes supporting a RuntimeClass.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s nodeSelector => { Str => 1 };

=attr nodeSelector

nodeSelector lists labels that must be present on nodes that support this RuntimeClass. Pods using this RuntimeClass can only be scheduled to a node matched by this selector. The RuntimeClass nodeSelector is merged with a pod's existing nodeSelector. Any conflicts will cause the pod to be rejected in admission.

=cut

k8s tolerations => ['Core::V1::Toleration'];

=attr tolerations

tolerations are appended (excluding duplicates) to pods running with this RuntimeClass during admission, effectively unioning the set of nodes tolerated by the pod and the RuntimeClass.

=cut

1;
