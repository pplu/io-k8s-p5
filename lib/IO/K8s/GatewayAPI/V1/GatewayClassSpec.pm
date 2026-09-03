package IO::K8s::GatewayAPI::V1::GatewayClassSpec;
# ABSTRACT: Spec defines the desired state of GatewayClass.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s controllerName => Str, { required => 'schema', pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\/[A-Za-z0-9\/\-._~%!\$&'()*+,;=:]+$/ };
k8s description    => Str;
k8s parametersRef  => '+IO::K8s::GatewayAPI::V1::ParametersReference';

=attr controllerName

ControllerName is the name of the controller that is managing Gateways of
this class. The value of this field MUST be a domain prefixed path.

Example: "example.net/gateway-controller".

This field is not mutable and cannot be empty.

Support: Core

=cut

=attr description

Description helps describe a GatewayClass with more details.

=cut

=attr parametersRef

ParametersRef is a reference to a resource that contains the configuration
parameters corresponding to the GatewayClass. This is optional if the
controller does not require any additional configuration.

ParametersRef can reference a standard Kubernetes resource, i.e. ConfigMap,
or an implementation-specific custom resource. The resource can be
cluster-scoped or namespace-scoped.

If the referent cannot be found, refers to an unsupported kind, or when
the data within that resource is malformed, the GatewayClass SHOULD be
rejected with the "Accepted" status condition set to "False" and an
"InvalidParameters" reason.

A Gateway for this GatewayClass may provide its own `parametersRef`. When both are specified,
the merging behavior is implementation specific.
It is generally recommended that GatewayClass provides defaults that can be overridden by a Gateway.

Support: Implementation-specific

=cut

1;
