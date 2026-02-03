package IO::K8s::Api::Core::V1::NodeSpec;
# ABSTRACT: NodeSpec describes the attributes that a node is created with.

use IO::K8s::Resource;

k8s configSource => 'Core::V1::NodeConfigSource';

=attr configSource

Deprecated: Previously used to specify the source of the node's configuration for the DynamicKubeletConfig feature. This feature is removed.

=cut

k8s externalID => Str;

=attr externalID

Deprecated. Not all kubelets will set this field. Remove field after 1.13. see: https://issues.k8s.io/61966

=cut

k8s podCIDR => Str;

=attr podCIDR

PodCIDR represents the pod IP range assigned to the node.

=cut

k8s podCIDRs => [Str];

=attr podCIDRs

podCIDRs represents the IP ranges assigned to the node for usage by Pods on that node. If this field is specified, the 0th entry must match the podCIDR field. It may contain at most 1 value for each of IPv4 and IPv6.

=cut

k8s providerID => Str;

=attr providerID

ID of the node assigned by the cloud provider in the format: <ProviderName>://<ProviderSpecificNodeID>

=cut

k8s taints => ['Core::V1::Taint'];

=attr taints

If specified, the node's taints.

=cut

k8s unschedulable => Bool;

=attr unschedulable

Unschedulable controls node schedulability of new pods. By default, node is schedulable. More info: https://kubernetes.io/docs/concepts/nodes/node/#manual-node-administration

=cut

1;
