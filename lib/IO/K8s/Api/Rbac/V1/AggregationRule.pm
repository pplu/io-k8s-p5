package IO::K8s::Api::Rbac::V1::AggregationRule;
# ABSTRACT: AggregationRule describes how to locate ClusterRoles to aggregate into the ClusterRole
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s clusterRoleSelectors => ['Meta::V1::LabelSelector'];

=attr clusterRoleSelectors

ClusterRoleSelectors holds a list of selectors which will be used to find ClusterRoles and create the rules. If any of the selectors match, then the ClusterRole's permissions will be added

=cut

1;
