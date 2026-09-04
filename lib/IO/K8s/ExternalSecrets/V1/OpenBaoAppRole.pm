package IO::K8s::ExternalSecrets::V1::OpenBaoAppRole;
# ABSTRACT: AppRole authenticates with OpenBao using the [App Role auth mechanism], with the role and secret stored in a Kubernetes Secret resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s path      => Str, { required => 'schema', default => 'approle' };
k8s roleId    => Str;
k8s roleRef   => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s secretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr path

Path where the App Role authentication backend is mounted
in OpenBao, e.g: "approle"

=cut

=attr roleId

RoleID configured in the App Role authentication backend when setting
up the authentication backend in OpenBao.

=cut

=attr roleRef

Reference to a key in a Secret that contains the App Role ID used
to authenticate with OpenBao.
The `key` field must be specified and denotes which entry within the Secret
resource is used as the app role id.

=cut

=attr secretRef

Reference to a key in a Secret that contains the App Role secret used
to authenticate with OpenBao.
The `key` field must be specified and denotes which entry within the Secret
resource is used as the app role secret.

=cut

1;
