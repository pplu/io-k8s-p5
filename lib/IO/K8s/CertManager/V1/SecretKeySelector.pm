package IO::K8s::CertManager::V1::SecretKeySelector;
# ABSTRACT: The SecretAccessKey is used for authentication.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s key  => Str;
k8s name => Str, { required => 'schema' };

=attr key

The key of the entry in the Secret resource's `data` field to be used.
Some instances of this field may be defaulted, in others it may be
required.

=cut

=attr name

Name of the resource being referred to.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names

=cut

1;
