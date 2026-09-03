package IO::K8s::Cilium::V2::ENI;
# ABSTRACT: ENI represents an AWS Elastic Network Interface More details: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s addresses           => [Str];
k8s 'availability-zone' => Str;
k8s description         => Str;
k8s id                  => Str;
k8s ip                  => Str;
k8s 'ipv6-prefixes'     => [Str];
k8s mac                 => Str;
k8s number              => Int;
k8s prefixes            => [Str];
k8s 'public-ip'         => Str;
k8s 'security-groups'   => [Str];
k8s subnet              => '+IO::K8s::Cilium::V2::AwsSubnet';
k8s tags                => { Str => 1 };
k8s vpc                 => '+IO::K8s::Cilium::V2::AwsVPC';

=attr addresses

Addresses is the list of all secondary IPs associated with the ENI

=cut

=attr availability-zone

AvailabilityZone is the availability zone of the ENI

=cut

=attr description

Description is the description field of the ENI

=cut

=attr id

ID is the ENI ID

=cut

=attr ip

IP is the primary IP of the ENI

=cut

=attr ipv6-prefixes

IPv6Prefixes is the list of all IPv6 /80 delegated prefixes associated with the ENI

=cut

=attr mac

MAC is the mac address of the ENI

=cut

=attr number

Number is the interface index, it used in combination with
FirstInterfaceIndex

=cut

=attr prefixes

Prefixes is the list of all IPv4 /28 delegated prefixes associated with the ENI

=cut

=attr public-ip

PublicIP is the public IP associated with the ENI

=cut

=attr security-groups

SecurityGroups are the security groups associated with the ENI

=cut

=attr subnet

Subnet is the subnet the ENI is associated with

=cut

=attr tags

Tags is the set of tags of the ENI. Used to detect ENIs which should
not be managed by Cilium

=cut

=attr vpc

VPC is the VPC information to which the ENI is attached to

=cut

1;
