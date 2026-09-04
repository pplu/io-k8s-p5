package IO::K8s::ExternalSecrets::V1alpha1::SecretRef;
# ABSTRACT: Secret ref to fill in credentials
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s key  => Str;
k8s name => Str;

=attr key

The key where the token is found.

=cut

=attr name

The name of the Secret resource being referred to.

=cut

1;
