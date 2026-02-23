package IO::K8s::Api::Core::V1::ConfigMapKeySelector;
# ABSTRACT: Selects a key from a ConfigMap.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s key => Str, 'required';

=attr key

The key to select.

=cut

k8s name => Str;

=attr name

Name of the referent. This field is effectively required, but due to backwards compatibility is allowed to be empty. Instances of this type with an empty value here are almost certainly wrong. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names

=cut

k8s optional => Bool;

=attr optional

Specify whether the ConfigMap or its key must be defined

=cut

1;
