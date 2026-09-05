package IO::K8s::ExternalSecrets::V1alpha1::SecretRef;
# ABSTRACT: Secret ref to fill in credentials
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s key  => Str, { pattern => qr/^[-._a-zA-Z0-9]+$/ };
k8s name => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };

=attr key

The key where the token is found.

=cut

=attr name

The name of the Secret resource being referred to.

=cut

1;
