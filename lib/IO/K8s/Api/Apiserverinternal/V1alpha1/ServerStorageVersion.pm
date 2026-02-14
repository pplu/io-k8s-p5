package IO::K8s::Api::Apiserverinternal::V1alpha1::ServerStorageVersion;
# ABSTRACT: An API server instance reports the version it can decode and the version it encodes objects to when persisting objects in the backend.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s apiServerID => Str;

=attr apiServerID

The ID of the reporting API server.

=cut

k8s decodableVersions => [Str];

=attr decodableVersions

The API server can decode objects encoded in these versions. The encodingVersion must be included in the decodableVersions.

=cut

k8s encodingVersion => Str;

=attr encodingVersion

The API server encodes the object to this version when persisting it in the backend (e.g., etcd).

=cut

k8s servedVersions => [Str];

=attr servedVersions

The API server can serve these versions. DecodableVersions must include all ServedVersions.

=cut

1;
