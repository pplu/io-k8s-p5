package IO::K8s::Api::Admissionregistration::V1beta1::Variable;
# ABSTRACT: Variable is the definition of a variable that is used for composition. A variable is defined as a named expression.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s expression => Str, 'required';

=attr expression

Expression is the expression that will be evaluated as the value of the variable. The CEL expression has access to the same identifiers as the CEL expressions in Validation.

=cut

k8s name => Str, 'required';

=attr name

Name is the name of the variable. The name must be a valid CEL identifier and unique among all variables. The variable can be accessed in other expressions through `variables` For example, if name is "foo", the variable will be available as `variables.foo`

=cut

1;
