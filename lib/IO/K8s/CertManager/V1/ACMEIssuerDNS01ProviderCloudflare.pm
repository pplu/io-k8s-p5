package IO::K8s::CertManager::V1::ACMEIssuerDNS01ProviderCloudflare;
# ABSTRACT: Use the Cloudflare API to manage DNS01 challenge records.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiKeySecretRef   => '+IO::K8s::CertManager::V1::SecretKeySelector';
k8s apiTokenSecretRef => '+IO::K8s::CertManager::V1::SecretKeySelector';
k8s email             => Str;

=attr apiKeySecretRef

API key to use to authenticate with Cloudflare.
Note: using an API token to authenticate is now the recommended method
as it allows greater control of permissions.

=cut

=attr apiTokenSecretRef

API token used to authenticate with Cloudflare.

=cut

=attr email

Email of the account, only required when using API key based authentication.

=cut

1;
