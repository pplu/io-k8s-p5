package IO::K8s::ExternalSecrets::V1::ExternalSecretSpec;
# ABSTRACT: ExternalSecretSpec defines the desired state of ExternalSecret.
our $VERSION = '1.108';
use utf8;
use IO::K8s::Resource;

k8s data            => ['+IO::K8s::ExternalSecrets::V1::ExternalSecretData'];
k8s dataFrom        => ['+IO::K8s::ExternalSecrets::V1::ExternalSecretDataFromRemoteRef'];
k8s refreshInterval => Str, { default => '1h0m0s' };
k8s refreshPolicy   => Str, { enum => [qw(CreatedOnce Periodic OnChange)] };
k8s secretStoreRef  => '+IO::K8s::ExternalSecrets::V1::SecretStoreRef';
k8s syncWindows     => '+IO::K8s::ExternalSecrets::V1::ExternalSecretSyncWindows';
k8s target          => '+IO::K8s::ExternalSecrets::V1::ExternalSecretTarget', { default => {'creationPolicy' => 'Owner','deletionPolicy' => 'Retain'} };

=encoding UTF-8

=cut

=attr data

Data defines the connection between the Kubernetes Secret keys and the Provider data

=cut

=attr dataFrom

DataFrom is used to fetch all properties from a specific Provider data
If multiple entries are specified, the Secret keys are merged in the specified order

=cut

=attr refreshInterval

RefreshInterval is the amount of time before the values are read again from the SecretStore provider,
specified as Golang Duration strings.
Valid time units are "ns", "us" (or "µs"), "ms", "s", "m", "h"
Example values: "1h0m0s", "2h30m0s", "10m0s"
May be set to "0s" to fetch and create it once. Defaults to 1h0m0s.

=cut

=attr refreshPolicy

RefreshPolicy determines how the ExternalSecret should be refreshed:
- CreatedOnce: Creates the Secret only if it does not exist and does not update it thereafter
- Periodic: Synchronizes the Secret from the external source at regular intervals specified by refreshInterval.
  No periodic updates occur if refreshInterval is 0.
- OnChange: Only synchronizes the Secret when the ExternalSecret's metadata or specification changes

=cut

=attr secretStoreRef

SecretStoreRef defines which SecretStore to fetch the ExternalSecret data.

=cut

=attr syncWindows

SyncWindows optionally restricts when periodic refreshes may occur.
Evaluated in UTC, only for Periodic refresh policy (or when refreshPolicy is unset).

=cut

=attr target

ExternalSecretTarget defines the Kubernetes Secret to be created,
there can be only one target per ExternalSecret.

=cut

1;
