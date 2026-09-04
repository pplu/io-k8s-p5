package IO::K8s::ExternalSecrets::V1::VaultLdapAuth;
# ABSTRACT: Ldap authenticates with Vault by passing username/password pair using the LDAP authentication method
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s path      => Str, { required => 'schema', default => 'ldap' };
k8s secretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s username  => Str, { required => 'schema' };

=attr path

Path where the LDAP authentication backend is mounted
in Vault, e.g: "ldap"

=cut

=attr secretRef

SecretRef to a key in a Secret resource containing password for the LDAP
user used to authenticate with Vault using the LDAP authentication
method

=cut

=attr username

Username is an LDAP username used to authenticate using the LDAP Vault
authentication method

=cut

1;
