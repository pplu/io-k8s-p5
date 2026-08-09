package IO::K8s::Api::Storagemigration::V1beta1::StorageVersionMigrationStatus;
# ABSTRACT: Status of the storage version migration.
our $VERSION = '1.106';
use IO::K8s::Resource;

k8s conditions => ['Meta::V1::Condition'];

=attr conditions

The latest available observations of the migration's current state.

=cut

k8s resourceVersion => Str;

=attr resourceVersion

ResourceVersion to compare with the GC cache for performing the migration. This is the current resource version of given group, version and resource when kube-controller-manager first observes this StorageVersionMigration resource.

=cut

1;
