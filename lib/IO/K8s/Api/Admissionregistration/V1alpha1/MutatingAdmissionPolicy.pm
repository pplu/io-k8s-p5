package IO::K8s::Api::Admissionregistration::V1alpha1::MutatingAdmissionPolicy;
# ABSTRACT: MutatingAdmissionPolicy describes the definition of an admission mutation policy that mutates the object coming into admission chain.
our $VERSION = '1.107';
use IO::K8s::APIObject;

=description

MutatingAdmissionPolicy describes the definition of an admission mutation policy that mutates the object coming into admission chain.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Admissionregistration::V1alpha1::MutatingAdmissionPolicySpec';

=attr spec

spec defines the desired behavior of the MutatingAdmissionPolicy.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.36/#mutatingadmissionpolicy-v1alpha1-admissionregistration.k8s.io>


=cut
1;
