package IO::K8s::Api::Core::V1::ComponentCondition;
# ABSTRACT: Information about the condition of a component.

use IO::K8s::Resource;

k8s error => Str;

=attr error

Condition error code for a component. For example, a health check error code.

=cut

k8s message => Str;

=attr message

Message about the condition for a component. For example, information about a health check.

=cut

k8s status => Str, 'required';

=attr status

Status of the condition for a component. Valid values for "Healthy": "True", "False", or "Unknown".

=cut

k8s type => Str, 'required';

=attr type

Type of condition for a component. Valid value: "Healthy"

=cut

1;
