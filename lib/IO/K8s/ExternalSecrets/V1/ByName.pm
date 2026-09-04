package IO::K8s::ExternalSecrets::V1::ByName;
# ABSTRACT: ByName configures the provider to interpret the `data.secretKey.remoteRef.key` field in ExternalSecret as secret name.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s folderID => Str, { required => 'schema' };

=attr folderID

The folder to fetch secrets from

=cut

1;
