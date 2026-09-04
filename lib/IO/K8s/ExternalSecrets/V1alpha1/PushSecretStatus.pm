package IO::K8s::ExternalSecrets::V1alpha1::PushSecretStatus;
# ABSTRACT: PushSecretStatus indicates the history of the status of PushSecret.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conditions            => ['Core::V1::NamespaceCondition'];
k8s refreshTime           => Time, { nullable => 1 };
k8s syncedPushSecrets     => { Str => 1 };
k8s syncedResourceVersion => Str;

=attr conditions

No description in the upstream schema.

=cut

=attr refreshTime

refreshTime is the time and date the external secret was fetched and
the target secret updated

=cut

=attr syncedPushSecrets

Synced PushSecrets, including secrets that already exist in provider.
Matches secret stores to PushSecretData that was stored to that secret store.

=cut

=attr syncedResourceVersion

SyncedResourceVersion keeps track of the last synced version.

=cut

1;
