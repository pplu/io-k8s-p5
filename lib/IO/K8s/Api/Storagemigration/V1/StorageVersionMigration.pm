package IO::K8s::Api::Storagemigration::V1::StorageVersionMigration;
# ABSTRACT: StorageVersionMigration represents a migration of stored data to the latest storage version.
our $VERSION = '1.108';
use IO::K8s::APIObject;

=description

StorageVersionMigration represents a migration of stored data to the latest storage version.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Storagemigration::V1::StorageVersionMigrationSpec';

=attr spec

Specification of the migration.

=cut

k8s status => 'Storagemigration::V1::StorageVersionMigrationStatus';

=attr status

Status of the migration.

=cut

=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.37/#storageversionmigration-v1-storagemigration.k8s.io>


=cut
1;
