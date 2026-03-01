package IO::K8s::Api::Authorization::V1::SubjectAccessReviewStatus;
# ABSTRACT: SubjectAccessReviewStatus
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s allowed => Bool, 'required';

=attr allowed

Allowed is required. True if the action would be allowed, false otherwise.

=cut

k8s denied => Bool;

=attr denied

Denied is optional. True if the action would be denied, otherwise false. If both allowed is false and denied is false, then the authorizer has no opinion on whether to authorize the action. Denied may not be true if Allowed is true.

=cut

k8s evaluationError => Str;

=attr evaluationError

EvaluationError is an indication that some error occurred during the authorization check. It is entirely possible to get an error and be able to continue determine authorization status in spite of it. For instance, RBAC can be missing a role, but enough roles are still present and bound to reason about the request.

=cut

k8s reason => Str;

=attr reason

Reason is optional.  It indicates why a request was allowed or denied.

=cut

1;
