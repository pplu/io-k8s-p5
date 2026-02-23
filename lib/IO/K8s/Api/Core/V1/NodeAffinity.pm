package IO::K8s::Api::Core::V1::NodeAffinity;
# ABSTRACT: Node affinity is a group of node affinity scheduling rules.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s preferredDuringSchedulingIgnoredDuringExecution => ['Core::V1::PreferredSchedulingTerm'];

=attr preferredDuringSchedulingIgnoredDuringExecution

The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred.

=cut

k8s requiredDuringSchedulingIgnoredDuringExecution => 'Core::V1::NodeSelector';

=attr requiredDuringSchedulingIgnoredDuringExecution

If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node.

=cut

1;
