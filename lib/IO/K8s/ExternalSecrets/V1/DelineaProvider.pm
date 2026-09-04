package IO::K8s::ExternalSecrets::V1::DelineaProvider;
# ABSTRACT: Delinea DevOps Secrets Vault https://docs.delinea.com/online-help/products/devops-secrets-vault/current
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s clientId     => '+IO::K8s::ExternalSecrets::V1::DelineaProviderSecretRef', { required => 'schema' };
k8s clientSecret => '+IO::K8s::ExternalSecrets::V1::DelineaProviderSecretRef', { required => 'schema' };
k8s tenant       => Str, { required => 'schema' };
k8s tld          => Str;
k8s urlTemplate  => Str;

=attr clientId

ClientID is the non-secret part of the credential.

=cut

=attr clientSecret

ClientSecret is the secret part of the credential.

=cut

=attr tenant

Tenant is the chosen hostname / site name.

=cut

=attr tld

TLD is based on the server location that was chosen during provisioning.
If unset, defaults to "com".

=cut

=attr urlTemplate

URLTemplate
If unset, defaults to "https://%s.secretsvaultcloud.%s/v1/%s%s".

=cut

1;
