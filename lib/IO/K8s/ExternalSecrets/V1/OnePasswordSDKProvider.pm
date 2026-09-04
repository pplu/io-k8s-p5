package IO::K8s::ExternalSecrets::V1::OnePasswordSDKProvider;
# ABSTRACT: OnePasswordSDK configures this store to use 1Password's new Go SDK to sync secrets.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth            => '+IO::K8s::ExternalSecrets::V1::OnePasswordSDKAuth', { required => 'schema' };
k8s cache           => '+IO::K8s::ExternalSecrets::V1::CacheConfig';
k8s environment     => Str;
k8s integrationInfo => '+IO::K8s::ExternalSecrets::V1::IntegrationInfo';
k8s vault           => Str;

=attr auth

Auth defines the information necessary to authenticate against OnePassword API.

=cut

=attr cache

Cache configures client-side caching for read operations (GetSecret, GetSecretMap).
When enabled, secrets are cached with the specified TTL.
Write operations (PushSecret, DeleteSecret) automatically invalidate relevant cache entries.
If omitted, caching is disabled (default).
cache: {} is a valid option to set.

=cut

=attr environment

Environment defines the 1Password Environment ID to read variables from.
Environments are read-only: PushSecret, DeleteSecret, and SecretExists return an error when set.
Mutually exclusive with Vault.

=cut

=attr integrationInfo

IntegrationInfo specifies the name and version of the integration built using the 1Password Go SDK.
If you don't know which name and version to use, use `DefaultIntegrationName` and `DefaultIntegrationVersion`, respectively.

=cut

=attr vault

Vault defines the vault's name or uuid to access. Do NOT add op:// prefix. This will be done automatically.
Mutually exclusive with Environment.

=cut

1;
