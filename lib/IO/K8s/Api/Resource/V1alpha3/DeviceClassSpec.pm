package IO::K8s::Api::Resource::V1alpha3::DeviceClassSpec;
# ABSTRACT: DeviceClassSpec is used in a [DeviceClass] to define what can be allocated and how to configure it.

use IO::K8s::Resource;

k8s config => ['Resource::V1alpha3::DeviceClassConfiguration'];

=attr config

Config defines configuration parameters that apply to each device that is claimed via this class. Some classses may potentially be satisfied by multiple drivers, so each instance of a vendor configuration applies to exactly one driver.

They are passed to the driver, but are not considered while allocating the claim.

=cut

k8s selectors => ['Resource::V1alpha3::DeviceSelector'];

=attr selectors

Each selector must be satisfied by a device which is claimed via this class.

=cut

k8s suitableNodes => 'Core::V1::NodeSelector';

=attr suitableNodes

Only nodes matching the selector will be considered by the scheduler when trying to find a Node that fits a Pod when that Pod uses a claim that has not been allocated yet *and* that claim gets allocated through a control plane controller. It is ignored when the claim does not use a control plane controller for allocation.

Setting this field is optional. If unset, all Nodes are candidates.

This is an alpha field and requires enabling the DRAControlPlaneController feature gate.

=cut

1;
