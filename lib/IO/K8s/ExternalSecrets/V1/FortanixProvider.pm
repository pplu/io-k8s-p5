package IO::K8s::ExternalSecrets::V1::FortanixProvider;
# ABSTRACT: Fortanix configures this store to sync secrets using the Fortanix provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiKey => '+IO::K8s::ExternalSecrets::V1::FortanixProviderSecretRef';
k8s apiUrl => Str;

=attr apiKey

APIKey is the API token to access SDKMS Applications.

=cut

=attr apiUrl

APIURL is the URL of SDKMS API. Defaults to `sdkms.fortanix.com`.

=cut

1;
