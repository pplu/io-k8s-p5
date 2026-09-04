package IO::K8s::ExternalSecrets::V1::GCPSMProvider;
# ABSTRACT: GCPSM configures this store to sync secrets using Google Cloud Platform Secret Manager provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth                         => '+IO::K8s::ExternalSecrets::V1::GCPSMAuth';
k8s location                     => Str;
k8s projectID                    => Str;
k8s secretVersionSelectionPolicy => Str, { default => 'LatestOrFail' };

=attr auth

Auth defines the information necessary to authenticate against GCP

=cut

=attr location

Location optionally defines a location for a secret

=cut

=attr projectID

ProjectID project where secret is located

=cut

=attr secretVersionSelectionPolicy

SecretVersionSelectionPolicy specifies how the provider selects a secret version
when "latest" is disabled or destroyed.
Possible values are:
- LatestOrFail: the provider always uses "latest", or fails if that version is disabled/destroyed.
- LatestOrFetch: the provider falls back to fetching the latest version if the version is DESTROYED or DISABLED

=cut

1;
