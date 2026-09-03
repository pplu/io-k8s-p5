package IO::K8s::GatewayAPI::V1beta1::TLSConfig;
# ABSTRACT: TLS store the configuration that will be applied to all Listeners handling HTTPS traffic and matching given port.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s validation => '+IO::K8s::GatewayAPI::V1beta1::FrontendTLSValidation';

=attr validation

Validation holds configuration information for validating the frontend (client).
Setting this field will result in mutual authentication when connecting to the gateway.
In browsers this may result in a dialog appearing
that requests a user to specify the client certificate.
The maximum depth of a certificate chain accepted in verification is Implementation specific.

Support: Core

=cut

1;
