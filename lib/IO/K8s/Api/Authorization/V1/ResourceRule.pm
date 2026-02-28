package IO::K8s::Api::Authorization::V1::ResourceRule;
# ABSTRACT: ResourceRule is the list of actions the subject is allowed to perform on resources. The list ordering isn't significant, may contain duplicates, and possibly be incomplete.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s apiGroups => [Str];

=attr apiGroups

APIGroups is the name of the APIGroup that contains the resources.  If multiple API groups are specified, any action requested against one of the enumerated resources in any API group will be allowed.  "*" means all.

=cut

k8s resourceNames => [Str];

=attr resourceNames

ResourceNames is an optional white list of names that the rule applies to.  An empty set means that everything is allowed.  "*" means all.

=cut

k8s resources => [Str];

=attr resources

Resources is a list of resources this rule applies to.  "*" means all in the specified apiGroups.
 "*/foo" represents the subresource 'foo' for all resources in the specified apiGroups.

=cut

k8s verbs => [Str], 'required';

=attr verbs

Verb is a list of kubernetes resource API verbs, like: get, list, watch, create, update, delete, proxy.  "*" means all.

=cut

1;
