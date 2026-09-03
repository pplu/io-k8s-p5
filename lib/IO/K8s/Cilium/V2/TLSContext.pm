package IO::K8s::Cilium::V2::TLSContext;
# ABSTRACT: TerminatingTLS is the TLS context for the connection terminated by the L7 proxy.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s certificate => Str;
k8s privateKey  => Str;
k8s secret      => 'Core::V1::SecretReference', { required => 'schema' };
k8s trustedCA   => Str;

=attr certificate

Certificate is the file name or k8s secret item name for the certificate
chain. If omitted, 'tls.crt' is assumed, if it exists. If given, the
item must exist.

=cut

=attr privateKey

PrivateKey is the file name or k8s secret item name for the private key
matching the certificate chain. If omitted, 'tls.key' is assumed, if it
exists. If given, the item must exist.

=cut

=attr secret

Secret is the secret that contains the certificates and private key for
the TLS context.
By default, Cilium will search in this secret for the following items:
 - 'ca.crt'  - Which represents the trusted CA to verify remote source.
 - 'tls.crt' - Which represents the public key certificate.
 - 'tls.key' - Which represents the private key matching the public key
               certificate.

=cut

=attr trustedCA

TrustedCA is the file name or k8s secret item name for the trusted CA.
If omitted, 'ca.crt' is assumed, if it exists. If given, the item must
exist.

=cut

1;
