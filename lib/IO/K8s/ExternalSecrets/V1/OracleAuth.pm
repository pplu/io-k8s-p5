package IO::K8s::ExternalSecrets::V1::OracleAuth;
# ABSTRACT: Auth configures how secret-manager authenticates with the Oracle Vault.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretRef => '+IO::K8s::ExternalSecrets::V1::OracleSecretRef', { required => 'schema' };
k8s tenancy   => Str, { required => 'schema' };
k8s user      => Str, { required => 'schema' };

=attr secretRef

SecretRef to pass through sensitive information.

=cut

=attr tenancy

Tenancy is the tenancy OCID where user is located.

=cut

=attr user

User is an access OCID specific to the account.

=cut

1;
