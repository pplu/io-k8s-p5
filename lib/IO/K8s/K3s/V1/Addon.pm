package IO::K8s::K3s::V1::Addon;
# ABSTRACT: Addon is used to track application of a manifest file on disk.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'k3s.cattle.io/v1',
    resource_plural => 'addons';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::K3s::V1::AddonSpec', { required => 'schema' };

=attr spec

Spec provides information about the on-disk manifest backing this resource.

=cut

1;
