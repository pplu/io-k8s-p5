package IO::K8s::Api::Rbac::V1::ClusterRole;
# ABSTRACT: ClusterRole is a cluster level, logical grouping of PolicyRules that can be referenced as a unit by a RoleBinding or ClusterRoleBinding.
our $VERSION = '1.002';
use IO::K8s::APIObject;

=description

ClusterRole is a cluster level, logical grouping of PolicyRules that can be referenced as a unit by a RoleBinding or ClusterRoleBinding.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s aggregationRule => 'Rbac::V1::AggregationRule';

=attr aggregationRule

AggregationRule is an optional field that describes how to build the Rules for this ClusterRole. If AggregationRule is set, then the Rules are controller managed and direct changes to Rules will be stomped by the controller.


=cut

k8s rules => ['Rbac::V1::PolicyRule'];

=attr rules

Rules holds all the PolicyRules for this ClusterRole


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#clusterrole-v1-rbac.authorization.k8s.io>


=cut
1;
