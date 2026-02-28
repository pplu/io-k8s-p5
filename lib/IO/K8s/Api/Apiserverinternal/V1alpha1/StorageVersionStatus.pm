package IO::K8s::Api::Apiserverinternal::V1alpha1::StorageVersionStatus;
# ABSTRACT: API server instances report the versions they can decode and the version they encode objects to when persisting objects in the backend.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s commonEncodingVersion => Str;

=attr commonEncodingVersion

If all API server instances agree on the same encoding storage version, then this field is set to that version. Otherwise this field is left empty. API servers should finish updating its storageVersionStatus entry before serving write operations, so that this field will be in sync with the reality.

=cut

k8s conditions => ['Apiserverinternal::V1alpha1::StorageVersionCondition'];

=attr conditions

The latest available observations of the storageVersion's state.

=cut

k8s storageVersions => ['Apiserverinternal::V1alpha1::ServerStorageVersion'];

=attr storageVersions

The reported versions per API server instance.

=cut

1;
