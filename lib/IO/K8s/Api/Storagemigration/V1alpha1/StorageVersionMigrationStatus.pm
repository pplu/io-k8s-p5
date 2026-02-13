package IO::K8s::Api::Storagemigration::V1alpha1::StorageVersionMigrationStatus;
# ABSTRACT: Status of the storage version migration.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s conditions => ['Storagemigration::V1alpha1::MigrationCondition'];

=attr conditions

The latest available observations of the migration's current state.

=cut

k8s resourceVersion => Str;

=attr resourceVersion

ResourceVersion to compare with the GC cache for performing the migration. This is the current resource version of given group, version and resource when kube-controller-manager first observes this StorageVersionMigration resource.

=cut

1;
