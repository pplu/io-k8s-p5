package IO::K8s::Api::Policy::V1::PodDisruptionBudget;
# ABSTRACT: PodDisruptionBudget is an object to define the max disruption that can be caused to a collection of pods

use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=head1 DESCRIPTION

PodDisruptionBudget is an object to define the max disruption that can be caused to a collection of pods

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'Policy::V1::PodDisruptionBudgetSpec';

=attr spec

Specification of the desired behavior of the PodDisruptionBudget.

=cut

k8s status => 'Policy::V1::PodDisruptionBudgetStatus';

=attr status

Most recently observed status of the PodDisruptionBudget.

=cut

1;
