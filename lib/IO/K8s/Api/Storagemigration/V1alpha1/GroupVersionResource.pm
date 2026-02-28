package IO::K8s::Api::Storagemigration::V1alpha1::GroupVersionResource;
# ABSTRACT: The names of the group, the version, and the resource.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s group => Str;

=attr group

The name of the group.

=cut

k8s resource => Str;

=attr resource

The name of the resource.

=cut

k8s version => Str;

=attr version

The name of the version.

=cut

1;
