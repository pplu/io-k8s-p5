package IO::K8s::ExternalSecrets::V1::VaultUserPassAuth;
# ABSTRACT: UserPass authenticates with Vault by passing username/password pair
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s path      => Str, { required => 'schema', default => 'userpass' };
k8s secretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s username  => Str, { required => 'schema' };

=attr path

Path where the UserPassword authentication backend is mounted
in Vault, e.g: "userpass"

=cut

=attr secretRef

SecretRef to a key in a Secret resource containing password for the
user used to authenticate with Vault using the UserPass authentication
method

=cut

=attr username

Username is a username used to authenticate using the UserPass Vault
authentication method

=cut

1;
