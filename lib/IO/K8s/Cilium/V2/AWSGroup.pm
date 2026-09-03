package IO::K8s::Cilium::V2::AWSGroup;
# ABSTRACT: AWSGroup is an structure that can be used to whitelisting information from AWS integration
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s labels              => { Str => 1 };
k8s region              => Str;
k8s securityGroupsIds   => [Str];
k8s securityGroupsNames => [Str];

=attr labels

Labels selects AWS ENIs by labels.
Multiple labels are AND-ed together.

=cut

=attr region

Deprecated: Region is unused.

=cut

=attr securityGroupsIds

SecurityGroupsIds selects VPC SecurityGroups by IDs.
If multiple IDs are specified, they are OR-ed together.

Note that this may be AND-ed with any Names specified. Specifying both
IDs and Names is not recommended.

=cut

=attr securityGroupsNames

SecurityGroupsNames selects VPC SecurityGroups by name.
If multiple names are specified, they are OR-ed together.

Note that this may be AND-ed with any IDs specified. Specifying both
IDs and Names is not recommended.

=cut

1;
