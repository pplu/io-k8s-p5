package IO::K8s::Api::Core::V1::SecretKeySelector;
# ABSTRACT: SecretKeySelector selects a key of a Secret.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s key => Str, 'required';

=attr key

The key of the secret to select from.  Must be a valid secret key.

=cut

k8s name => Str;

=attr name

Name of the referent. This field is effectively required, but due to backwards compatibility is allowed to be empty. Instances of this type with an empty value here are almost certainly wrong. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names

=cut

k8s optional => Bool;

=attr optional

Specify whether the Secret or its key must be defined

=cut

1;
