package IO::K8s::Api::Networking::V1::NetworkPolicy;
# ABSTRACT: NetworkPolicy describes what network traffic is allowed for a set of Pods
our $VERSION = '1.005';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced', 'IO::K8s::Role::NetworkPolicy';
sub _netpol_format { 'core' }

=description

NetworkPolicy describes what network traffic is allowed for a set of Pods

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Networking::V1::NetworkPolicySpec';

=attr spec

spec represents the specification of the desired behavior for this NetworkPolicy.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#networkpolicy-v1-networking.k8s.io>


=cut
1;
