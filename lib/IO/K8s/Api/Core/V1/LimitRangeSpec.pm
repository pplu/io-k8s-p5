package IO::K8s::Api::Core::V1::LimitRangeSpec;
# ABSTRACT: LimitRangeSpec defines a min/max usage limit for resources that match on kind.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s limits => ['Core::V1::LimitRangeItem'], 'required';

=attr limits

Limits is the list of LimitRangeItem objects that are enforced.

=cut

1;
