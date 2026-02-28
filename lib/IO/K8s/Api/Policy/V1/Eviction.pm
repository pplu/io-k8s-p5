package IO::K8s::Api::Policy::V1::Eviction;
# ABSTRACT: Eviction evicts a pod from its node subject to certain policies and safety constraints. This is a subresource of Pod.  A request to cause such an eviction is created by POSTing to .../pods/<pod name>/evictions.
our $VERSION = '1.006';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

Eviction evicts a pod from its node subject to certain policies and safety constraints. This is a subresource of Pod.  A request to cause such an eviction is created by POSTing to .../pods/<pod name>/evictions.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s deleteOptions => 'Meta::V1::DeleteOptions';

=attr deleteOptions

DeleteOptions may be provided


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#eviction-v1-policy.k8s.io>


=cut
1;
