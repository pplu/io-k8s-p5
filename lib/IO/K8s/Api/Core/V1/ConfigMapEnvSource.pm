package IO::K8s::Api::Core::V1::ConfigMapEnvSource;
# ABSTRACT: ConfigMapEnvSource selects a ConfigMap to populate the environment variables with. The contents of the target ConfigMap's Data field will represent the key-value pairs as environment variables.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s name => Str;

=attr name

Name of the referent. This field is effectively required, but due to backwards compatibility is allowed to be empty. Instances of this type with an empty value here are almost certainly wrong. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names

=cut

k8s optional => Bool;

=attr optional

Specify whether the ConfigMap must be defined

=cut

1;
