package IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::GroupResource;
# ABSTRACT: GroupResource specifies a Group and a Resource, but does not force a version.  This is useful for identifying concepts during lookup stages without having partially valid types
our $VERSION = '1.107';
use IO::K8s::Resource;

k8s group => Str, 'required';

=attr group

The name of the group.

=cut

k8s resource => Str, 'required';

=attr resource

The name of the resource.

=cut

1;
