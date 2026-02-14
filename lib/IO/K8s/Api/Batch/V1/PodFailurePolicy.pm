package IO::K8s::Api::Batch::V1::PodFailurePolicy;
# ABSTRACT: PodFailurePolicy describes how failed pods influence the backoffLimit.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s rules => ['Batch::V1::PodFailurePolicyRule'], 'required';

=attr rules

A list of pod failure policy rules. The rules are evaluated in order. Once a rule matches a Pod failure, the remaining of the rules are ignored. When no rule matches the Pod failure, the default handling applies - the counter of pod failures is incremented and it is checked against the backoffLimit. At most 20 elements are allowed.

=cut

1;
