package IO::K8s::Api::Authorization::V1::SelfSubjectRulesReviewSpec;
# ABSTRACT: SelfSubjectRulesReviewSpec defines the specification for SelfSubjectRulesReview.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s namespace => Str;

=attr namespace

Namespace to evaluate rules for. Required.

=cut

1;
