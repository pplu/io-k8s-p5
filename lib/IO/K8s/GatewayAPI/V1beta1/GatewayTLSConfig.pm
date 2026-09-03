package IO::K8s::GatewayAPI::V1beta1::GatewayTLSConfig;
# ABSTRACT: TLS specifies frontend and backend tls configuration for entire gateway.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s backend  => '+IO::K8s::GatewayAPI::V1beta1::GatewayBackendTLS';
k8s frontend => '+IO::K8s::GatewayAPI::V1beta1::FrontendTLSConfig';

=attr backend

Backend describes TLS configuration for gateway when connecting
to backends.

Note that this contains only details for the Gateway as a TLS client,
and does _not_ imply behavior about how to choose which backend should
get a TLS connection. That is determined by the presence of a BackendTLSPolicy.

Support: Core

=cut

=attr frontend

Frontend describes TLS config when client connects to Gateway.
Support: Core

=cut

1;
