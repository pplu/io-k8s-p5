package IO::K8s::ExternalSecrets::V1::SecretKeySelector;
# ABSTRACT: SecretKeySelector references a key in a Secret, optionally in another namespace
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s key       => Str, { pattern => qr/^[-._a-zA-Z0-9]+$/ };
k8s name      => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };
k8s namespace => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?$/ };

=attr key

A key in the referenced Secret.
Some instances of this field may be defaulted, in others it may be required.

=cut

=attr name

The name of the Secret resource being referred to.

=cut

=attr namespace

The namespace of the Secret resource being referred to.
Ignored if referent is not cluster-scoped, otherwise defaults to the namespace of the referent.

=cut

1;
