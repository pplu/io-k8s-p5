package IO::K8s::Api::Storagemigration::V1alpha1::MigrationCondition;
# ABSTRACT: Describes the state of a migration at a certain point.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s lastUpdateTime => Time;

=attr lastUpdateTime

The last time this condition was updated.

=cut

k8s message => Str;

=attr message

A human readable message indicating details about the transition.

=cut

k8s reason => Str;

=attr reason

The reason for the condition's last transition.

=cut

k8s status => Str, 'required';

=attr status

Status of the condition, one of True, False, Unknown.

=cut

k8s type => Str, 'required';

=attr type

Type of the condition.

=cut

1;
