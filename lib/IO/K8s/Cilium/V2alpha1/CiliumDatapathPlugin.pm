package IO::K8s::Cilium::V2alpha1::CiliumDatapathPlugin;
# ABSTRACT: A CiliumDatapathPlugin registers a datapath plugin with Cilium and contains information about its status and how Cilium should interact with it.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliumdatapathplugins';

k8s spec => '+IO::K8s::Cilium::V2alpha1::CiliumDatapathPluginSpec', { required => 'schema' };

=attr spec

No description in the upstream schema.

=cut

1;
