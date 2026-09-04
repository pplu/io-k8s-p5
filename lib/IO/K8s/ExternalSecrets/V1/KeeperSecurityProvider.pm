package IO::K8s::ExternalSecrets::V1::KeeperSecurityProvider;
# ABSTRACT: KeeperSecurity configures this store to sync secrets using the KeeperSecurity provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s authRef            => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s folderID           => Str, { required => 'schema' };
k8s getByTitleFallback => Bool;

=attr authRef

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr folderID

No description in the upstream schema.

=cut

=attr getByTitleFallback

No description in the upstream schema.

=cut

1;
