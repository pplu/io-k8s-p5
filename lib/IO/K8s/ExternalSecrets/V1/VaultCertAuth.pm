package IO::K8s::ExternalSecrets::V1::VaultCertAuth;
# ABSTRACT: Cert authenticates with TLS Certificates by passing client certificate, private key and ca certificate Cert authentication method
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s clientCert => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s path       => Str, { default => 'cert' };
k8s secretRef  => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s vaultRole  => Str;

=attr clientCert

ClientCert is a certificate to authenticate using the Cert Vault
authentication method

=cut

=attr path

Path where the Certificate authentication backend is mounted
in Vault, e.g: "cert"

=cut

=attr secretRef

SecretRef to a key in a Secret resource containing client private key to
authenticate with Vault using the Cert authentication method

=cut

=attr vaultRole

VaultRole specifies the Vault role to use for TLS certificate authentication.

=cut

1;
