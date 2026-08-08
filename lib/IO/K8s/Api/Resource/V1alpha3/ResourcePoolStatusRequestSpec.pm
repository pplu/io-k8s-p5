package IO::K8s::Api::Resource::V1alpha3::ResourcePoolStatusRequestSpec;
# ABSTRACT: ResourcePoolStatusRequestSpec defines the filters for the pool status request.
our $VERSION = '1.106';
use IO::K8s::Resource;

k8s driver => Str, 'required';

=attr driver

Driver specifies the DRA driver name to filter pools. Only pools from ResourceSlices with this driver will be included. Must be a DNS subdomain (e.g., "gpu.example.com").

=cut

k8s limit => Int;

=attr limit

Limit optionally specifies the maximum number of pools to return in the status. If more pools match the filter criteria, the response will be truncated (i.e., len(status.pools) < status.poolCount).

Default: 100. Minimum: 1. Maximum: 1000.

=cut

k8s poolName => Str;

=attr poolName

PoolName optionally filters to a specific pool name. If not specified, all pools from the specified driver are included. When specified, must be a non-empty valid resource pool name (DNS subdomains separated by "/").

=cut

1;
