package IO::K8s::Api::Storagemigration::V1::StorageVersionMigrationSpec;
# ABSTRACT: Spec of the storage version migration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s resource => 'Meta::V1::GroupResource', 'required';

=attr resource

The resource that is being migrated. The migrator sends requests to the endpoint serving the resource. Immutable.

=cut

1;
