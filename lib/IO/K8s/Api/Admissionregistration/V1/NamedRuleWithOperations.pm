package IO::K8s::Api::Admissionregistration::V1::NamedRuleWithOperations;
# ABSTRACT: NamedRuleWithOperations is a tuple of Operations and Resources with ResourceNames.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s apiGroups => [Str];

=attr apiGroups

APIGroups is the API groups the resources belong to. '*' is all groups. If '*' is present, the length of the slice must be one. Required.

=cut

k8s apiVersions => [Str];

=attr apiVersions

APIVersions is the API versions the resources belong to. '*' is all versions. If '*' is present, the length of the slice must be one. Required.

=cut

k8s operations => [Str];

=attr operations

Operations is the operations the admission hook cares about - CREATE, UPDATE, DELETE, CONNECT or * for all of those operations and any future admission operations that are added. If '*' is present, the length of the slice must be one. Required.

=cut

k8s resourceNames => [Str];

=attr resourceNames

ResourceNames is an optional white list of names that the rule applies to.  An empty set means that everything is allowed.

=cut

k8s resources => [Str];

=attr resources

Resources is a list of resources this rule applies to.

For example: 'pods' means pods. 'pods/log' means the log subresource of pods. '*' means all resources, but not subresources. 'pods/*' means all subresources of pods. '*/scale' means all scale subresources. '*/*' means all resources and their subresources.

If wildcard is present, the validation rule will ensure resources do not overlap with each other.

Depending on the enclosing object, subresources might not be allowed. Required.

=cut

k8s scope => Str;

=attr scope

scope specifies the scope of this rule. Valid values are "Cluster", "Namespaced", and "*" "Cluster" means that only cluster-scoped resources will match this rule. Namespace API objects are cluster-scoped. "Namespaced" means that only namespaced resources will match this rule. "*" means that there are no scope restrictions. Subresources match the scope of their parent resource. Default is "*".

=cut

1;
