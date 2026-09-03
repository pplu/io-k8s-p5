package IO::K8s::Cilium::V2::CiliumEnvoyConfig;
# ABSTRACT: CiliumEnvoyConfig
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumenvoyconfigs';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::Cilium::V2::CiliumEnvoyConfigSpec';

=attr spec

No description in the upstream schema.

=cut

1;
