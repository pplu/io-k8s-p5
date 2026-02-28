package IO::K8s::Api::Rbac::V1::PolicyRule;
# ABSTRACT: PolicyRule holds information that describes a policy rule, but does not contain information about who the rule applies to or which namespace the rule applies to.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s apiGroups => [Str];

=attr apiGroups

APIGroups is the name of the APIGroup that contains the resources.  If multiple API groups are specified, any action requested against one of the enumerated resources in any API group will be allowed. "" represents the core API group and "*" represents all API groups.

=cut

k8s nonResourceURLs => [Str];

=attr nonResourceURLs

NonResourceURLs is a set of partial urls that a user should have access to.  *s are allowed, but only as the full, final step in the path Since non-resource URLs are not namespaced, this field is only applicable for ClusterRoles referenced from a ClusterRoleBinding. Rules can either apply to API resources (such as "pods" or "secrets") or non-resource URL paths (such as "/api"),  but not both.

=cut

k8s resourceNames => [Str];

=attr resourceNames

ResourceNames is an optional white list of names that the rule applies to.  An empty set means that everything is allowed.

=cut

k8s resources => [Str];

=attr resources

Resources is a list of resources this rule applies to. '*' represents all resources.

=cut

k8s verbs => [Str], 'required';

=attr verbs

Verbs is a list of Verbs that apply to ALL the ResourceKinds contained in this rule. '*' represents all verbs.

=cut

1;
