package IO::K8s::Cilium::V2::CiliumBGPClusterConfig;
# ABSTRACT: CiliumBGPClusterConfig is the Schema for the CiliumBGPClusterConfig API
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumbgpclusterconfigs';

k8s spec   => '+IO::K8s::Cilium::V2::CiliumBGPClusterConfigSpec', { required => 'schema' };
k8s status => '+IO::K8s::Cilium::V2::CiliumBGPClusterConfigStatus';

=attr spec

Spec defines the desired cluster configuration of the BGP control plane.

=cut

=attr status

Status is a running status of the cluster configuration

=cut

1;
