package IO::K8s::ExternalSecrets::V1::DVLSProvider;
# ABSTRACT: DVLS configures this store to sync secrets using Devolutions Server provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth      => '+IO::K8s::ExternalSecrets::V1::DVLSAuth', { required => 'schema' };
k8s insecure  => Bool;
k8s serverUrl => Str, { required => 'schema' };
k8s vault     => Str;

=attr auth

Auth defines the authentication method to use.

=cut

=attr insecure

Insecure allows connecting to DVLS over plain HTTP.
This is NOT RECOMMENDED for production use.
Set to true only if you understand the security implications.

=cut

=attr serverUrl

ServerURL is the DVLS instance URL (e.g., https://dvls.example.com).

=cut

=attr vault

Vault is the name or UUID of the vault to fetch secrets from.
When omitted, the vault must be specified in the secret key using the legacy format "<vault-id>/<entry-id>".

=cut

1;
