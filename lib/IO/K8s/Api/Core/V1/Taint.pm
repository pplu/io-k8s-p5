package IO::K8s::Api::Core::V1::Taint;
# ABSTRACT: The node this Taint is attached to has the "effect" on any pod that does not tolerate the Taint.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s effect => Str, 'required';

=attr effect

Required. The effect of the taint on pods that do not tolerate the taint. Valid effects are NoSchedule, PreferNoSchedule and NoExecute.

=cut

k8s key => Str, 'required';

=attr key

Required. The taint key to be applied to a node.

=cut

k8s timeAdded => Time;

=attr timeAdded

TimeAdded represents the time at which the taint was added. It is only written for NoExecute taints.

=cut

k8s value => Str;

=attr value

The taint value corresponding to the taint key.

=cut

1;
