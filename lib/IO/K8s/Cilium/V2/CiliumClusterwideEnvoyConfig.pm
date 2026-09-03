package IO::K8s::Cilium::V2::CiliumClusterwideEnvoyConfig;
# ABSTRACT: CiliumClusterwideEnvoyConfig
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumclusterwideenvoyconfigs';

k8s spec => '+IO::K8s::Cilium::V2::CiliumEnvoyConfigSpec';

=attr spec

No description in the upstream schema.

=cut

1;
