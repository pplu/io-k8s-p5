package IO::K8s::Api::Networking::V1::IPBlock;
# ABSTRACT: IPBlock describes a particular CIDR (Ex. "192.168.1.0/24","2001:db8::/64") that is allowed to the pods matched by a NetworkPolicySpec's podSelector. The except entry describes CIDRs that should not be included within this rule.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s cidr => Str, 'required';

=attr cidr

cidr is a string representing the IPBlock Valid examples are "192.168.1.0/24" or "2001:db8::/64"

=cut

k8s except => [Str];

=attr except

except is a slice of CIDRs that should not be included within an IPBlock Valid examples are "192.168.1.0/24" or "2001:db8::/64" Except values will be rejected if they are outside the cidr range

=cut

1;
