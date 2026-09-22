package IO::K8s::ExternalSecrets::V1::ExternalSecretStatus;
# ABSTRACT: ExternalSecretStatus defines the observed state of ExternalSecret.
our $VERSION = '1.109';
use IO::K8s::Resource;

k8s binding               => '+IO::K8s::ExternalSecrets::V1::LocalObjectReference';
k8s conditions            => ['+IO::K8s::ExternalSecrets::V1::ExternalSecretStatusCondition'];
k8s refreshTime           => Time, { nullable => 1 };
k8s syncedResourceVersion => Str;

=attr binding

Binding represents a servicebinding.io Provisioned Service reference to the secret

=cut

=attr conditions

No description in the upstream schema.

=cut

=attr refreshTime

refreshTime is the time and date the external secret was fetched and
the target secret updated

=cut

=attr syncedResourceVersion

SyncedResourceVersion keeps track of the last synced version

=cut

1;
