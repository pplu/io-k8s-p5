package IO::K8s::Api::Networking::V1beta1::ServiceCIDRSpec;
# ABSTRACT: ServiceCIDRSpec define the CIDRs the user wants to use for allocating ClusterIPs for Services.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s cidrs => [Str];

=attr cidrs

CIDRs defines the IP blocks in CIDR notation (e.g. "192.168.0.0/24" or "2001:db8::/64") from which to assign service cluster IPs. Max of two CIDRs is allowed, one of each IP family. This field is immutable.

=cut

1;
