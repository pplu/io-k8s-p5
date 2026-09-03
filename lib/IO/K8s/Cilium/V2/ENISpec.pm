package IO::K8s::Cilium::V2::ENISpec;
# ABSTRACT: ENI is the AWS ENI specific configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s 'availability-zone'         => Str;
k8s 'delete-on-termination'     => Bool;
k8s 'disable-prefix-delegation' => Bool;
k8s 'exclude-interface-tags'    => { Str => 1 };
k8s 'first-interface-index'     => Int, { minimum => 0 };
k8s 'instance-type'             => Str;
k8s 'node-subnet-id'            => Str;
k8s 'security-group-tags'       => { Str => 1 };
k8s 'security-groups'           => [Str];
k8s 'subnet-ids'                => [Str];
k8s 'subnet-tags'               => { Str => 1 };
k8s 'use-primary-address'       => Bool;
k8s 'vpc-id'                    => Str;

=attr availability-zone

AvailabilityZone is the availability zone to use when allocating
ENIs.

=cut

=attr delete-on-termination

DeleteOnTermination defines that the ENI should be deleted when the
associated instance is terminated. If the parameter is not set the
default behavior is to delete the ENI on instance termination.

=cut

=attr disable-prefix-delegation

DisablePrefixDelegation determines whether ENI prefix delegation should be
disabled on this node.

=cut

=attr exclude-interface-tags

ExcludeInterfaceTags is the list of tags to use when excluding ENIs for
Cilium IP allocation. Any interface matching this set of tags will not
be managed by Cilium.

=cut

=attr first-interface-index

FirstInterfaceIndex is the index of the first ENI to use for IP
allocation, e.g. if the node has eth0, eth1, eth2 and
FirstInterfaceIndex is set to 1, then only eth1 and eth2 will be
used for IP allocation, eth0 will be ignored for PodIP allocation.

=cut

=attr instance-type

InstanceType is the AWS EC2 instance type, e.g. "m5.large"

=cut

=attr node-subnet-id

NodeSubnetID is the subnet of the primary ENI the instance was brought up
with. It is used as a sensible default subnet to create ENIs in.

=cut

=attr security-group-tags

SecurityGroupTags is the list of tags to use when evaliating what
AWS security groups to use for the ENI.

=cut

=attr security-groups

SecurityGroups is the list of security groups to attach to any ENI
that is created and attached to the instance.

=cut

=attr subnet-ids

SubnetIDs is the list of subnet ids to use when evaluating what AWS
subnets to use for ENI and IP allocation.

=cut

=attr subnet-tags

SubnetTags is the list of tags to use when evaluating what AWS
subnets to use for ENI and IP allocation.

=cut

=attr use-primary-address

UsePrimaryAddress determines whether an ENI's primary address
should be available for allocations on the node

=cut

=attr vpc-id

VpcID is the VPC ID to use when allocating ENIs.

=cut

1;
