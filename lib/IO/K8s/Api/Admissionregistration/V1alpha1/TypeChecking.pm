package IO::K8s::Api::Admissionregistration::V1alpha1::TypeChecking;
# ABSTRACT: TypeChecking contains results of type checking the expressions in the ValidatingAdmissionPolicy
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s expressionWarnings => ['Admissionregistration::V1alpha1::ExpressionWarning'];

=attr expressionWarnings

The type checking warnings for each expression.

=cut

1;
