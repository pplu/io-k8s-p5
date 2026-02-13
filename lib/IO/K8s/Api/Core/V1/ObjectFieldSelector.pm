package IO::K8s::Api::Core::V1::ObjectFieldSelector;
# ABSTRACT: ObjectFieldSelector selects an APIVersioned field of an object.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s apiVersion => Str;

=attr apiVersion

Version of the schema the FieldPath is written in terms of, defaults to "v1".

=cut

k8s fieldPath => Str, 'required';

=attr fieldPath

Path of the field to select in the specified API version.

=cut

1;
