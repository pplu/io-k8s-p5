package IO::K8s::Api::Admissionregistration::V1::ValidatingAdmissionPolicyBinding;
# ABSTRACT: ValidatingAdmissionPolicyBinding binds the ValidatingAdmissionPolicy with paramerized resources. ValidatingAdmissionPolicyBinding and parameter CRDs together define how cluster administrators configure policies for clusters.
our $VERSION = '1.005';
use IO::K8s::APIObject;

=description

ValidatingAdmissionPolicyBinding binds the ValidatingAdmissionPolicy with paramerized resources. ValidatingAdmissionPolicyBinding and parameter CRDs together define how cluster administrators configure policies for clusters.

For a given admission request, each binding will cause its policy to be evaluated N times, where N is 1 for policies/bindings that don't use params, otherwise N is the number of parameters selected by the binding.

The CEL expressions of a policy must have a computed CEL cost below the maximum CEL budget. Each evaluation of the policy is given an independent CEL cost budget. Adding/removing policies, bindings, or params can not affect whether a given (policy, binding, param) combination is within its own CEL budget.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Admissionregistration::V1::ValidatingAdmissionPolicyBindingSpec';

=attr spec

Specification of the desired behavior of the ValidatingAdmissionPolicyBinding.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#validatingadmissionpolicybinding-v1-admissionregistration.k8s.io>


=cut
1;
