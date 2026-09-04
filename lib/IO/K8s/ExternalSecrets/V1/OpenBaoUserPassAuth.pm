package IO::K8s::ExternalSecrets::V1::OpenBaoUserPassAuth;
# ABSTRACT: UserPass authenticates with OpenBao by passing a username/password pair
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s path      => Str, { required => 'schema', default => 'userpass' };
k8s secretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s username  => Str, { required => 'schema' };

=attr path

Path where the UserPassword authentication backend is mounted
in OpenBao, e.g: "userpass"

=cut

=attr secretRef

SecretRef to a key in a Secret resource containing password for the user
used to authenticate with OpenBao using the [UserPass authentication
method]

[UserPass authentication method]: https://openbao.org/docs/auth/userpass/

=cut

=attr username

Username is a username used to authenticate using the [UserPass
authentication method]

[UserPass authentication method]: https://openbao.org/docs/auth/userpass/

=cut

1;
