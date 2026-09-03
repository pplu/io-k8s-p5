package IO::K8s::GatewayAPI::V1beta1::AllowedListeners;
# ABSTRACT: AllowedListeners defines which ListenerSets can be attached to this Gateway.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s namespaces => '+IO::K8s::GatewayAPI::V1beta1::ListenerNamespaces', { default => {'from' => 'None'} };

=attr namespaces

Namespaces defines which namespaces ListenerSets can be attached to this Gateway.
The default value is to allow no ListenerSets.

=cut

1;
