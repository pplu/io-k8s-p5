package IO::K8s::Api::Storagemigration::V1alpha1::StorageVersionMigrationSpec;
# ABSTRACT: Spec of the storage version migration.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s continueToken => Str;

=attr continueToken

The token used in the list options to get the next chunk of objects to migrate. When the .status.conditions indicates the migration is "Running", users can use this token to check the progress of the migration.

=cut

k8s resource => 'Storagemigration::V1alpha1::GroupVersionResource', 'required';

=attr resource

The resource that is being migrated. The migrator sends requests to the endpoint serving the resource. Immutable.

=cut

1;
