package IO::K8s::Traefik::V1alpha1::IPStrategy;
# ABSTRACT: IPStrategy holds the IP strategy configuration used by Traefik to determine the client IP.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s depth       => Int, { minimum => 0 };
k8s excludedIPs => [Str];
k8s ipv6Subnet  => Int;

=attr depth

Depth tells Traefik to use the X-Forwarded-For header and take the IP located at the depth position (starting from the right).

=cut

=attr excludedIPs

ExcludedIPs configures Traefik to scan the X-Forwarded-For header and select the first IP not in the list.

=cut

=attr ipv6Subnet

IPv6Subnet configures Traefik to consider all IPv6 addresses from the defined subnet as originating from the same IP. Applies to RemoteAddrStrategy and DepthStrategy.

=cut

1;
