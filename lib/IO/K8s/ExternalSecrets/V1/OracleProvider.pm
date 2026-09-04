package IO::K8s::ExternalSecrets::V1::OracleProvider;
# ABSTRACT: Oracle configures this store to sync secrets using Oracle Vault provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth              => '+IO::K8s::ExternalSecrets::V1::OracleAuth';
k8s compartment       => Str;
k8s encryptionKey     => Str;
k8s principalType     => Str, { enum => ['','UserPrincipal','InstancePrincipal','Workload'] };
k8s region            => Str, { required => 'schema' };
k8s serviceAccountRef => '+IO::K8s::ExternalSecrets::V1::ServiceAccountSelector';
k8s vault             => Str, { required => 'schema' };

=attr auth

Auth configures how secret-manager authenticates with the Oracle Vault.
If empty, use the instance principal, otherwise the user credentials specified in Auth.

=cut

=attr compartment

Compartment is the vault compartment OCID.
Required for PushSecret

=cut

=attr encryptionKey

EncryptionKey is the OCID of the encryption key within the vault.
Required for PushSecret

=cut

=attr principalType

The type of principal to use for authentication. If left blank, the Auth struct will
determine the principal type. This optional field must be specified if using
workload identity.

=cut

=attr region

Region is the region where vault is located.

=cut

=attr serviceAccountRef

ServiceAccountRef specified the service account
that should be used when authenticating with WorkloadIdentity.

=cut

=attr vault

Vault is the vault's OCID of the specific vault where secret is located.

=cut

1;
