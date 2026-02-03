package IO::K8s::Api::Admissionregistration::V1beta1::TypeChecking;
# ABSTRACT: TypeChecking contains results of type checking the expressions in the ValidatingAdmissionPolicy

use IO::K8s::Resource;

k8s expressionWarnings => ['Admissionregistration::V1beta1::ExpressionWarning'];

=attr expressionWarnings

The type checking warnings for each expression.

=cut

1;
