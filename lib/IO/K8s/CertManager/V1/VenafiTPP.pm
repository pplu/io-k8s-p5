package IO::K8s::CertManager::V1::VenafiTPP;
# ABSTRACT: TPP specifies CyberArk Certificate Manager Self-Hosted configuration settings.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s caBundle          => Str;
k8s caBundleSecretRef => '+IO::K8s::CertManager::V1::SecretKeySelector';
k8s credentialsRef    => '+IO::K8s::CertManager::V1::LocalObjectReference', { required => 'schema' };
k8s url               => Str, { required => 'schema' };

=attr caBundle

Base64-encoded bundle of PEM CAs which will be used to validate the certificate
chain presented by the CyberArk Certificate Manager Self-Hosted server. Only used if using HTTPS; ignored for HTTP.
If undefined, the certificate bundle in the cert-manager controller container
is used to validate the chain.

=cut

=attr caBundleSecretRef

Reference to a Secret containing a base64-encoded bundle of PEM CAs
which will be used to validate the certificate chain presented by the CyberArk Certificate Manager Self-Hosted server.
Only used if using HTTPS; ignored for HTTP. Mutually exclusive with CABundle.
If neither CABundle nor CABundleSecretRef is defined, the certificate bundle in
the cert-manager controller container is used to validate the TLS connection.

=cut

=attr credentialsRef

CredentialsRef is a reference to a Secret containing the CyberArk Certificate Manager Self-Hosted API credentials.
The secret must contain the key 'access-token' for the Access Token Authentication,
or two keys, 'username' and 'password' for the API Keys Authentication.

=cut

=attr url

URL is the base URL for the vedsdk endpoint of the CyberArk Certificate Manager Self-Hosted instance,
for example: "https://tpp.example.com/vedsdk".

=cut

1;
