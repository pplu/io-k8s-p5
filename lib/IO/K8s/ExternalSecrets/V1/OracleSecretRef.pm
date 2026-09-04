package IO::K8s::ExternalSecrets::V1::OracleSecretRef;
# ABSTRACT: SecretRef to pass through sensitive information.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s fingerprint => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s privatekey  => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr fingerprint

Fingerprint is the fingerprint of the API private key.

=cut

=attr privatekey

PrivateKey is the user's API Signing Key in PEM format, used for authentication.

=cut

1;
