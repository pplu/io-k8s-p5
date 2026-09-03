package IO::K8s::CertManager::V1::ACMEExternalAccountBinding;
# ABSTRACT: ExternalAccountBinding is a reference to a CA external account of the ACME server.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s keyAlgorithm => Str, { enum => [qw(HS256 HS384 HS512)] };
k8s keyID        => Str, { required => 'schema' };
k8s keySecretRef => '+IO::K8s::CertManager::V1::SecretKeySelector', { required => 'schema' };

=attr keyAlgorithm

Deprecated: keyAlgorithm field exists for historical compatibility
reasons and should not be used. The algorithm is now hardcoded to HS256
in golang/x/crypto/acme.

=cut

=attr keyID

keyID is the ID of the CA key that the External Account is bound to.

=cut

=attr keySecretRef

keySecretRef is a Secret Key Selector referencing a data item in a Kubernetes
Secret which holds the symmetric MAC key of the External Account Binding.
The `key` is the index string that is paired with the key data in the
Secret and should not be confused with the key data itself, or indeed with
the External Account Binding keyID above.
The secret key stored in the Secret **must** be un-padded, base64 URL
encoded data.

=cut

1;
