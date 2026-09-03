package IO::K8s::GatewayAPI::V1::TLSPortConfig;
# ABSTRACT: TLSPortConfig
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s port => Int, { required => 'schema', minimum => 1, maximum => 65535 };
k8s tls  => '+IO::K8s::GatewayAPI::V1::TLSConfig', { required => 'schema' };

=attr port

The Port indicates the Port Number to which the TLS configuration will be
applied. This configuration will be applied to all Listeners handling HTTPS
traffic that match this port.

Support: Core

=cut

=attr tls

TLS store the configuration that will be applied to all Listeners handling
HTTPS traffic and matching given port.

Support: Core

=cut

1;
