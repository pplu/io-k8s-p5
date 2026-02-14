package IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::APIResource;
# ABSTRACT: APIResource specifies the name of a resource and whether it is namespaced.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s categories => [Str];

=attr categories

categories is a list of the grouped resources this resource belongs to (e.g. 'all')

=cut

k8s group => Str;

=attr group

group is the preferred group of the resource.  Empty implies the group of the containing resource list. For subresources, this may have a different value, for example: Scale".

=cut

k8s kind => Str, 'required';

=attr kind

kind is the kind for the resource (e.g. 'Foo' is the kind for a resource 'foo')

=cut

k8s name => Str, 'required';

=attr name

name is the plural name of the resource.

=cut

k8s namespaced => Bool, 'required';

=attr namespaced

namespaced indicates if a resource is namespaced or not.

=cut

k8s shortNames => [Str];

=attr shortNames

shortNames is a list of suggested short names of the resource.

=cut

k8s singularName => Str, 'required';

=attr singularName

singularName is the singular name of the resource.  This allows clients to handle plural and singular opaquely. The singularName is more correct for reporting status on a single item and both singular and plural are allowed from the kubectl CLI interface.

=cut

k8s storageVersionHash => Str;

=attr storageVersionHash

The hash value of the storage version, the version this resource is converted to when written to the data store. Value must be treated as opaque by clients. Only equality comparison on the value is valid. This is an alpha feature and may change or be removed in the future. The field is populated by the apiserver only if the StorageVersionHash feature gate is enabled. This field will remain optional even if it graduates.

=cut

k8s verbs => [Str], 'required';

=attr verbs

verbs is a list of supported kube verbs (this includes get, list, watch, create, update, patch, delete, deletecollection, and proxy)

=cut

k8s version => Str;

=attr version

version is the preferred version of the resource.  Empty implies the version of the containing resource list For subresources, this may have a different value, for example: v1 (while inside a v1beta1 version of the core resource's group)".

=cut

1;
