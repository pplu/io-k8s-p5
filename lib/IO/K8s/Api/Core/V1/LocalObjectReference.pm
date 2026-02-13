package IO::K8s::Api::Core::V1::LocalObjectReference;
# ABSTRACT: LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s name => Str;

=attr name

Name of the referent. This field is effectively required, but due to backwards compatibility is allowed to be empty. Instances of this type with an empty value here are almost certainly wrong. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names

=cut

1;
