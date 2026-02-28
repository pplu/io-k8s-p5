package IO::K8s::Api::Rbac::V1::Role;
# ABSTRACT: Role is a namespaced, logical grouping of PolicyRules that can be referenced as a unit by a RoleBinding.
our $VERSION = '1.006';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

Role is a namespaced, logical grouping of PolicyRules that can be referenced as a unit by a RoleBinding.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s rules => ['Rbac::V1::PolicyRule'];

=attr rules

Rules holds all the PolicyRules for this Role


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#role-v1-rbac.authorization.k8s.io>


=cut
1;
