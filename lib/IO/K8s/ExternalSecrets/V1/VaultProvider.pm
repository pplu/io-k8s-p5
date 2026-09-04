package IO::K8s::ExternalSecrets::V1::VaultProvider;
# ABSTRACT: Vault configures this store to sync secrets using the HashiCorp Vault provider.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth                => '+IO::K8s::ExternalSecrets::V1::VaultAuth';
k8s caBundle            => Str;
k8s caProvider          => '+IO::K8s::ExternalSecrets::V1::CAProvider';
k8s checkAndSet         => '+IO::K8s::ExternalSecrets::V1::VaultCheckAndSet';
k8s forwardInconsistent => Bool;
k8s headers             => { Str => 1 };
k8s namespace           => Str;
k8s path                => Str;
k8s readYourWrites      => Bool;
k8s server              => Str, { required => 'schema' };
k8s tls                 => '+IO::K8s::ExternalSecrets::V1::VaultClientTLS';
k8s version             => Str, { enum => [qw(v1 v2)], default => 'v2' };

=attr auth

Auth configures how secret-manager authenticates with the Vault server.

=cut

=attr caBundle

PEM encoded CA bundle used to validate Vault server certificate. Only used
if the Server URL is using HTTPS protocol. This parameter is ignored for
plain HTTP protocol connection. If not set the system root certificates
are used to validate the TLS connection.

=cut

=attr caProvider

The provider for the CA bundle to use to validate Vault server certificate.

=cut

=attr checkAndSet

CheckAndSet defines the Check-And-Set (CAS) settings for PushSecret operations.
Only applies to Vault KV v2 stores. When enabled, write operations must include
the current version of the secret to prevent unintentional overwrites.

=cut

=attr forwardInconsistent

ForwardInconsistent tells Vault to forward read-after-write requests to the Vault
leader instead of simply retrying within a loop. This can increase performance if
the option is enabled serverside.
https://www.vaultproject.io/docs/configuration/replication#allow_forwarding_via_header

=cut

=attr headers

Headers to be added in Vault request

=cut

=attr namespace

Name of the vault namespace. Namespaces is a set of features within Vault Enterprise that allows
Vault environments to support Secure Multi-tenancy. e.g: "ns1".
More about namespaces can be found here https://www.vaultproject.io/docs/enterprise/namespaces

=cut

=attr path

Path is the mount path of the Vault KV backend endpoint, e.g:
"secret". The v2 KV secret engine version specific "/data" path suffix
for fetching secrets from Vault is optional and will be appended
if not present in specified path.

=cut

=attr readYourWrites

ReadYourWrites ensures isolated read-after-write semantics by
providing discovered cluster replication states in each request.
More information about eventual consistency in Vault can be found here
https://www.vaultproject.io/docs/enterprise/consistency

=cut

=attr server

Server is the connection address for the Vault server, e.g: "https://vault.example.com:8200".

=cut

=attr tls

The configuration used for client side related TLS communication, when the Vault server
requires mutual authentication. Only used if the Server URL is using HTTPS protocol.
This parameter is ignored for plain HTTP protocol connection.
It's worth noting this configuration is different from the "TLS certificates auth method",
which is available under the `auth.cert` section.

=cut

=attr version

Version is the Vault KV secret engine version. This can be either "v1" or
"v2". Version defaults to "v2".

=cut

1;
