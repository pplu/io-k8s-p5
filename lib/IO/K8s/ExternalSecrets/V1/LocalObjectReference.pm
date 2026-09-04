package IO::K8s::ExternalSecrets::V1::LocalObjectReference;
# ABSTRACT: Binding represents a servicebinding.io Provisioned Service reference to the secret
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name => Str, { default => '' };

=attr name

Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names

=cut

1;
