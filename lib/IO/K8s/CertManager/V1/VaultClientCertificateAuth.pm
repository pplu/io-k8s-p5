package IO::K8s::CertManager::V1::VaultClientCertificateAuth;
# ABSTRACT: ClientCertificate authenticates with Vault by presenting a client certificate during the request's TLS handshake.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s mountPath  => Str;
k8s name       => Str;
k8s secretName => Str;

=attr mountPath

The Vault mountPath here is the mount path to use when authenticating with
Vault. For example, setting a value to `/v1/auth/foo`, will use the path
`/v1/auth/foo/login` to authenticate with Vault. If unspecified, the
default value "/v1/auth/cert" will be used.

=cut

=attr name

Name of the certificate role to authenticate against.
If not set, matching any certificate role, if available.

=cut

=attr secretName

Reference to Kubernetes Secret of type "kubernetes.io/tls" (hence containing
tls.crt and tls.key) used to authenticate to Vault using TLS client
authentication.

=cut

1;
