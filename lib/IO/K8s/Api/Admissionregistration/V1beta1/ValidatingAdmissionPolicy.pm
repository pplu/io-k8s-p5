package IO::K8s::Api::Admissionregistration::V1beta1::ValidatingAdmissionPolicy;
# ABSTRACT: ValidatingAdmissionPolicy describes the definition of an admission validation policy that accepts or rejects an object without changing it.
our $VERSION = '1.006';
use IO::K8s::APIObject;

=description

ValidatingAdmissionPolicy describes the definition of an admission validation policy that accepts or rejects an object without changing it.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Admissionregistration::V1beta1::ValidatingAdmissionPolicySpec';

=attr spec

Specification of the desired behavior of the ValidatingAdmissionPolicy.


=cut

k8s status => 'Admissionregistration::V1beta1::ValidatingAdmissionPolicyStatus';

=attr status

The status of the ValidatingAdmissionPolicy, including warnings that are useful to determine if the policy behaves in the expected way. Populated by the system. Read-only.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#validatingadmissionpolicy-v1beta1-admissionregistration.k8s.io>


=cut
1;
