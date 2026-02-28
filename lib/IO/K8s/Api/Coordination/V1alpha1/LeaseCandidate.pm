package IO::K8s::Api::Coordination::V1alpha1::LeaseCandidate;
# ABSTRACT: LeaseCandidate defines a candidate for a Lease object. Candidates are created such that coordinated leader election will pick the best leader from the list of candidates.
our $VERSION = '1.004';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

LeaseCandidate defines a candidate for a Lease object. Candidates are created such that coordinated leader election will pick the best leader from the list of candidates.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Coordination::V1alpha1::LeaseCandidateSpec';

=attr spec

spec contains the specification of the Lease. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#leasecandidate-v1alpha1-coordination.k8s.io>


=cut
1;
