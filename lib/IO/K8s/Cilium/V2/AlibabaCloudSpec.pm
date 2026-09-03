package IO::K8s::Cilium::V2::AlibabaCloudSpec;
# ABSTRACT: AlibabaCloud is the AlibabaCloud IPAM specific configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s 'availability-zone'   => Str;
k8s 'cidr-block'          => Str;
k8s 'instance-type'       => Str;
k8s 'security-group-tags' => { Str => 1 };
k8s 'security-groups'     => [Str];
k8s 'vpc-id'              => Str;
k8s 'vswitch-tags'        => { Str => 1 };
k8s vswitches             => [Str];

=attr availability-zone

AvailabilityZone is the availability zone to use when allocating
ENIs.

=cut

=attr cidr-block

CIDRBlock is vpc ipv4 CIDR

=cut

=attr instance-type

InstanceType is the ECS instance type, e.g. "ecs.g6.2xlarge"

=cut

=attr security-group-tags

SecurityGroupTags is the list of tags to use when evaluating which
security groups to use for the ENI.

=cut

=attr security-groups

SecurityGroups is the list of security groups to attach to any ENI
that is created and attached to the instance.

=cut

=attr vpc-id

VPCID is the VPC ID to use when allocating ENIs.

=cut

=attr vswitch-tags

VSwitchTags is the list of tags to use when evaluating which
vSwitch to use for the ENI.

=cut

=attr vswitches

VSwitches is the ID of vSwitch available for ENI

=cut

1;
