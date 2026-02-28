package IO::K8s::Api::Core::V1::LimitRangeItem;
# ABSTRACT: LimitRangeItem defines a min/max usage limit for any resource that matches on kind.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s default => { Str => 1 };

=attr default

Default resource requirement limit value by resource name if resource limit is omitted.

=cut

k8s defaultRequest => { Str => 1 };

=attr defaultRequest

DefaultRequest is the default resource requirement request value by resource name if resource request is omitted.

=cut

k8s max => { Str => 1 };

=attr max

Max usage constraints on this kind by resource name.

=cut

k8s maxLimitRequestRatio => { Str => 1 };

=attr maxLimitRequestRatio

MaxLimitRequestRatio if specified, the named resource must have a request and limit that are both non-zero where limit divided by request is less than or equal to the enumerated value; this represents the max burst for the named resource.

=cut

k8s min => { Str => 1 };

=attr min

Min usage constraints on this kind by resource name.

=cut

k8s type => Str, 'required';

=attr type

Type of resource that this limit applies to.

=cut

1;
