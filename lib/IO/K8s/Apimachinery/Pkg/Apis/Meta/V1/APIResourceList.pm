package IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::APIResourceList;
# ABSTRACT: APIResourceList is a list of APIResource, it is used to expose the name of the resources supported in a specific group and version, and if the resource is namespaced.
our $VERSION = '1.106';
use IO::K8s::Resource;

k8s apiVersion => Str;

=attr apiVersion

APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources

=cut

k8s groupVersion => Str, 'required';

=attr groupVersion

groupVersion is the group and version this APIResourceList is for.

=cut

k8s kind => Str;

=attr kind

Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds

=cut

k8s resources => ['Meta::V1::APIResource'], 'required';

=attr resources

resources contains the name of the resources and if they are namespaced.

=cut

1;
