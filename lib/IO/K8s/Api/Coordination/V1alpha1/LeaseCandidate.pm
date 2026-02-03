package IO::K8s::Api::Coordination::V1alpha1::LeaseCandidate;
# ABSTRACT: LeaseCandidate defines a candidate for a Lease object. Candidates are created such that coordinated leader election will pick the best leader from the list of candidates.

use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=head1 DESCRIPTION

LeaseCandidate defines a candidate for a Lease object. Candidates are created such that coordinated leader election will pick the best leader from the list of candidates.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'Coordination::V1alpha1::LeaseCandidateSpec';

=attr spec

spec contains the specification of the Lease. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

1;
