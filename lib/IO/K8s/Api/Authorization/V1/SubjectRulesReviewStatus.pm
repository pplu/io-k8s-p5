package IO::K8s::Api::Authorization::V1::SubjectRulesReviewStatus;
# ABSTRACT: SubjectRulesReviewStatus contains the result of a rules check. This check can be incomplete depending on the set of authorizers the server is configured with and any errors experienced during evaluation. Because authorization rules are additive, if a rule appears in a list it's safe to assume the subject has that permission, even if that list is incomplete.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s evaluationError => Str;

=attr evaluationError

EvaluationError can appear in combination with Rules. It indicates an error occurred during rule evaluation, such as an authorizer that doesn't support rule evaluation, and that ResourceRules and/or NonResourceRules may be incomplete.

=cut

k8s incomplete => Bool, 'required';

=attr incomplete

Incomplete is true when the rules returned by this call are incomplete. This is most commonly encountered when an authorizer, such as an external authorizer, doesn't support rules evaluation.

=cut

k8s nonResourceRules => ['Authorization::V1::NonResourceRule'], 'required';

=attr nonResourceRules

NonResourceRules is the list of actions the subject is allowed to perform on non-resources. The list ordering isn't significant, may contain duplicates, and possibly be incomplete.

=cut

k8s resourceRules => ['Authorization::V1::ResourceRule'], 'required';

=attr resourceRules

ResourceRules is the list of actions the subject is allowed to perform on resources. The list ordering isn't significant, may contain duplicates, and possibly be incomplete.

=cut

1;
