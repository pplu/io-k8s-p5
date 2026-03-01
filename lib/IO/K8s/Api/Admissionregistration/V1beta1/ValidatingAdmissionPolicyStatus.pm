package IO::K8s::Api::Admissionregistration::V1beta1::ValidatingAdmissionPolicyStatus;
# ABSTRACT: ValidatingAdmissionPolicyStatus represents the status of an admission validation policy.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s conditions => ['Meta::V1::Condition'];

=attr conditions

The conditions represent the latest available observations of a policy's current state.

=cut

k8s observedGeneration => Int;

=attr observedGeneration

The generation observed by the controller.

=cut

k8s typeChecking => 'Admissionregistration::V1beta1::TypeChecking';

=attr typeChecking

The results of type checking for each expression. Presence of this field indicates the completion of the type checking.

=cut

1;
