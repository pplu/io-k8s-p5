package IO::K8s::GatewayAPI::V1::PolicyAncestorStatus;
# ABSTRACT: PolicyAncestorStatus describes the status of a route with respect to an associated Ancestor.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s ancestorRef    => '+IO::K8s::GatewayAPI::V1::ParentReference', { required => 'schema' };
k8s conditions     => ['Meta::V1::Condition'], { required => 'schema' };
k8s controllerName => Str, { required => 'schema', pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\/[A-Za-z0-9\/\-._~%!\$&'()*+,;=:]+$/ };

=attr ancestorRef

AncestorRef corresponds with a ParentRef in the spec that this
PolicyAncestorStatus struct describes the status of.

=cut

=attr conditions

Conditions describes the status of the Policy with respect to the given Ancestor.

=cut

=attr controllerName

ControllerName is a domain/path string that indicates the name of the
controller that wrote this status. This corresponds with the
controllerName field on GatewayClass.

Example: "example.net/gateway-controller".

The format of this field is DOMAIN "/" PATH, where DOMAIN and PATH are
valid Kubernetes names
(https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

Controllers MUST populate this field when writing status. Controllers should ensure that
entries to status populated with their ControllerName are cleaned up when they are no
longer necessary.

=cut

1;
