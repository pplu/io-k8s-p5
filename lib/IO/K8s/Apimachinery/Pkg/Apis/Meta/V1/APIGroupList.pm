package IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::APIGroupList;
# ABSTRACT: APIGroupList is a list of APIGroup, to allow clients to discover the API at /apis.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiVersion => Str;

=attr apiVersion

APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources

=cut

k8s groups => ['Meta::V1::APIGroup'], 'required';

=attr groups

groups is a list of APIGroup.

=cut

k8s kind => Str;

=attr kind

Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds

=cut

1;
