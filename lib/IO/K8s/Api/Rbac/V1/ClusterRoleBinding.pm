package IO::K8s::Api::Rbac::V1::ClusterRoleBinding;
# ABSTRACT: ClusterRoleBinding references a ClusterRole, but not contain it.  It can reference a ClusterRole in the global namespace, and adds who information via Subject.
our $VERSION = '1.002';
use IO::K8s::APIObject;

=description

ClusterRoleBinding references a ClusterRole, but not contain it.  It can reference a ClusterRole in the global namespace, and adds who information via Subject.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s roleRef => 'Rbac::V1::RoleRef', 'required';

=attr roleRef

RoleRef can only reference a ClusterRole in the global namespace. If the RoleRef cannot be resolved, the Authorizer must return an error. This field is immutable.


=cut

k8s subjects => ['Rbac::V1::Subject'];

=attr subjects

Subjects holds references to the objects the role applies to.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#clusterrolebinding-v1-rbac.authorization.k8s.io>


=cut
1;
