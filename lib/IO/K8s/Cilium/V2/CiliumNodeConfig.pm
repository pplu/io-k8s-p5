package IO::K8s::Cilium::V2::CiliumNodeConfig;
# ABSTRACT: CiliumNodeConfig is a list of configuration key-value pairs.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumnodeconfigs';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::Cilium::V2::CiliumNodeConfigSpec', { required => 'schema' };

=attr spec

Spec is the desired Cilium configuration overrides for a given node

=cut

1;
