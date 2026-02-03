package IO::K8s::Api::Storagemigration::V1alpha1::StorageVersionMigration;
# ABSTRACT: StorageVersionMigration represents a migration of stored data to the latest storage version.

use IO::K8s::APIObject;

=head1 DESCRIPTION

StorageVersionMigration represents a migration of stored data to the latest storage version.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'Storagemigration::V1alpha1::StorageVersionMigrationSpec';

=attr spec

Specification of the migration.

=cut

k8s status => 'Storagemigration::V1alpha1::StorageVersionMigrationStatus';

=attr status

Status of the migration.

=cut

1;
