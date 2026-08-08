package IO::K8s::Api::Admissionregistration::V1::MutatingAdmissionPolicyBinding;
# ABSTRACT: MutatingAdmissionPolicyBinding binds the MutatingAdmissionPolicy with parametrized resources. MutatingAdmissionPolicyBinding and the optional parameter resource together define how cluster administrators configure policies for clusters.
our $VERSION = '1.106';
use IO::K8s::APIObject;

=description

MutatingAdmissionPolicyBinding binds the MutatingAdmissionPolicy with parametrized resources. MutatingAdmissionPolicyBinding and the optional parameter resource together define how cluster administrators configure policies for clusters.

For a given admission request, each binding will cause its policy to be evaluated N times, where N is 1 for policies/bindings that don't use params, otherwise N is the number of parameters selected by the binding. Each evaluation is constrained by a budget to limit the total amount of time or the total number of mutations that can occur.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Admissionregistration::V1::MutatingAdmissionPolicyBindingSpec';

=attr spec

spec defines the desired behavior of the MutatingAdmissionPolicyBinding.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.36/#mutatingadmissionpolicybinding-v1-admissionregistration.k8s.io>


=cut
1;
