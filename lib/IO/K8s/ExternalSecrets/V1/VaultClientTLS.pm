package IO::K8s::ExternalSecrets::V1::VaultClientTLS;
# ABSTRACT: The configuration used for client side related TLS communication, when the Vault server requires mutual authentication.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s certSecretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s keySecretRef  => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';

=attr certSecretRef

CertSecretRef is a certificate added to the transport layer
when communicating with the Vault server.
If no key for the Secret is specified, external-secret will default to 'tls.crt'.

=cut

=attr keySecretRef

KeySecretRef to a key in a Secret resource containing client private key
added to the transport layer when communicating with the Vault server.
If no key for the Secret is specified, external-secret will default to 'tls.key'.

=cut

1;
