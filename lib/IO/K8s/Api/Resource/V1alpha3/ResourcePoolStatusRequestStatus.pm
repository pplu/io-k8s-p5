package IO::K8s::Api::Resource::V1alpha3::ResourcePoolStatusRequestStatus;
# ABSTRACT: ResourcePoolStatusRequestStatus contains the calculated pool status information.
our $VERSION = '1.107';
use IO::K8s::Resource;

k8s conditions => ['Meta::V1::Condition'];

=attr conditions

Conditions provide information about the state of the request. A condition with type=Complete or type=Failed will always be set when the status is populated.

Known condition types:

- "Complete": True when the request has been processed successfully
- "Failed": True when the request could not be processed

=cut

k8s poolCount => Int, 'required';

=attr poolCount

PoolCount is the total number of pools that matched the filter criteria, regardless of truncation. This helps users understand how many pools exist even when the response is truncated. A value of 0 means no pools matched the filter criteria.

=cut

k8s pools => ['Resource::V1alpha3::PoolStatus'];

=attr pools

Pools contains the first C<spec.limit> matching pools, sorted by driver then pool name. If C<len(pools) < poolCount>, the list was truncated. When omitted, no pools matched the request filters.

=cut

1;
