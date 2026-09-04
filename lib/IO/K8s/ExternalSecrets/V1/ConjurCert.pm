package IO::K8s::ExternalSecrets::V1::ConjurCert;
# ABSTRACT: Cert enables certificate-based authentication using a client certificate and key.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s account       => Str, { required => 'schema' };
k8s clientCertRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s clientKeyRef  => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s hostId        => Str;
k8s serviceID     => Str, { required => 'schema' };

=attr account

Account is the Conjur organization account name.

=cut

=attr clientCertRef

ClientCertRef is a reference to a specific 'key' containing the client certificate
within a Secret resource. The certificate must be PEM-encoded.

=cut

=attr clientKeyRef

ClientKeyRef is a reference to a specific 'key' containing the private RSA client key
within a Secret resource. The key must be PEM-encoded.

=cut

=attr hostId

Optional HostID for cert authentication (can be omitted when using 'spiffe' mode).

=cut

=attr serviceID

The conjur authn cert webservice id

=cut

1;
