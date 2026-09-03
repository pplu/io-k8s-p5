package IO::K8s::CertManager::V1::VenafiCloud;
# ABSTRACT: Cloud specifies the CyberArk Certificate Manager SaaS configuration settings.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiTokenSecretRef => '+IO::K8s::CertManager::V1::SecretKeySelector', { required => 'schema' };
k8s url               => Str;

=attr apiTokenSecretRef

APITokenSecretRef is a secret key selector for the CyberArk Certificate Manager SaaS API token.

=cut

=attr url

URL is the base URL for CyberArk Certificate Manager SaaS.
Defaults to "https://api.venafi.cloud/".

=cut

1;
