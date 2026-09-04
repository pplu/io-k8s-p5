package IO::K8s::ExternalSecrets::V1::AzureCustomCloudConfig;
# ABSTRACT: CustomCloudConfig defines custom Azure endpoints for non-standard clouds.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s activeDirectoryEndpoint => Str, { required => 'schema' };
k8s keyVaultDNSSuffix       => Str;
k8s keyVaultEndpoint        => Str;
k8s resourceManagerEndpoint => Str;

=attr activeDirectoryEndpoint

ActiveDirectoryEndpoint is the AAD endpoint for authentication
Required when using custom cloud configuration

=cut

=attr keyVaultDNSSuffix

KeyVaultDNSSuffix is the DNS suffix for Key Vault URLs

=cut

=attr keyVaultEndpoint

KeyVaultEndpoint is the Key Vault service endpoint

=cut

=attr resourceManagerEndpoint

ResourceManagerEndpoint is the Azure Resource Manager endpoint

=cut

1;
