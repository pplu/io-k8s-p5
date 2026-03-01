package IO::K8s::Api::Rbac::V1::RoleBinding;
# ABSTRACT: RoleBinding references a role, but does not contain it.  It can reference a Role in the same namespace or a ClusterRole in the global namespace. It adds who information via Subjects and namespace information by which namespace it exists in.  RoleBindings in a given namespace only have effect in that namespace.
our $VERSION = '1.007';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

RoleBinding references a role, but does not contain it.  It can reference a Role in the same namespace or a ClusterRole in the global namespace. It adds who information via Subjects and namespace information by which namespace it exists in.  RoleBindings in a given namespace only have effect in that namespace.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s roleRef => 'Rbac::V1::RoleRef', 'required';

=attr roleRef

RoleRef can reference a Role in the current namespace or a ClusterRole in the global namespace. If the RoleRef cannot be resolved, the Authorizer must return an error. This field is immutable.


=cut

k8s subjects => ['Rbac::V1::Subject'];

=attr subjects

Subjects holds references to the objects the role applies to.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#rolebinding-v1-rbac.authorization.k8s.io>


=cut
1;
