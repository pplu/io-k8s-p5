package IO::K8s::KubeAggregator::Pkg::Apis::Apiregistration::V1::APIServiceStatus;
# ABSTRACT: APIServiceStatus contains derived information about an API server
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s conditions => ['KubeAggregator::V1::APIServiceCondition'];

=attr conditions

Current service state of apiService.

=cut

1;
