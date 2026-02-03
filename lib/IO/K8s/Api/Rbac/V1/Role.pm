package IO::K8s::Api::Rbac::V1::Role;
# ABSTRACT: Role is a namespaced, logical grouping of PolicyRules that can be referenced as a unit by a RoleBinding.

use IO::K8s::APIObject;

=head1 DESCRIPTION

Role is a namespaced, logical grouping of PolicyRules that can be referenced as a unit by a RoleBinding.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s rules => ['Rbac::V1::PolicyRule'];

=attr rules

Rules holds all the PolicyRules for this Role

=cut

1;
