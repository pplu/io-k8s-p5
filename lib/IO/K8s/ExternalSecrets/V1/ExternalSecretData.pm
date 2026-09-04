package IO::K8s::ExternalSecrets::V1::ExternalSecretData;
# ABSTRACT: ExternalSecretData defines the connection between the Kubernetes Secret key (spec.data.<key>) and the Provider data.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s remoteRef => '+IO::K8s::ExternalSecrets::V1::ExternalSecretDataRemoteRef', { required => 'schema' };
k8s secretKey => Str, { required => 'schema', pattern => qr/^[-._a-zA-Z0-9]+$/ };
k8s sourceRef => '+IO::K8s::ExternalSecrets::V1::StoreSourceRef';

=attr remoteRef

RemoteRef points to the remote secret and defines
which secret (version/property/..) to fetch.

=cut

=attr secretKey

The key in the Kubernetes Secret to store the value.

=cut

=attr sourceRef

SourceRef allows you to override the source
from which the value will be pulled.

=cut

1;
