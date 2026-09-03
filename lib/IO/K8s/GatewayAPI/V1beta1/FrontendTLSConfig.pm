package IO::K8s::GatewayAPI::V1beta1::FrontendTLSConfig;
# ABSTRACT: Frontend describes TLS config when client connects to Gateway.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s default => '+IO::K8s::GatewayAPI::V1beta1::TLSConfig', { required => 'schema' };
k8s perPort => ['+IO::K8s::GatewayAPI::V1beta1::TLSPortConfig'];

=attr default

Default specifies the default client certificate validation configuration
for all Listeners handling HTTPS traffic, unless a per-port configuration
is defined.

support: Core

=cut

=attr perPort

PerPort specifies tls configuration assigned per port.
Per port configuration is optional. Once set this configuration overrides
the default configuration for all Listeners handling HTTPS traffic
that match this port.
Each override port requires a unique TLS configuration.

support: Core

=cut

1;
