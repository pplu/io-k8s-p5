package IO::K8s::Api::Coordination::V1::Lease;
# ABSTRACT: Lease defines a lease concept.
our $VERSION = '1.005';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

Lease defines a lease concept.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Coordination::V1::LeaseSpec';

=attr spec

spec contains the specification of the Lease. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#lease-v1-coordination.k8s.io>


=cut
1;
