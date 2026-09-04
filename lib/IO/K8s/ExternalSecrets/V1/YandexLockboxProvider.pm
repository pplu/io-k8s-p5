package IO::K8s::ExternalSecrets::V1::YandexLockboxProvider;
# ABSTRACT: YandexLockbox configures this store to sync secrets using Yandex Lockbox provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiEndpoint => Str;
k8s auth        => '+IO::K8s::ExternalSecrets::V1::YandexAuth', { required => 'schema' };
k8s caProvider  => '+IO::K8s::ExternalSecrets::V1::YandexCAProvider';
k8s fetching    => '+IO::K8s::ExternalSecrets::V1::FetchingPolicy';

=attr apiEndpoint

Yandex.Cloud API endpoint (e.g. 'api.cloud.yandex.net:443')

=cut

=attr auth

Auth defines the information necessary to authenticate against Yandex.Cloud

=cut

=attr caProvider

The provider for the CA bundle to use to validate Yandex.Cloud server certificate.

=cut

=attr fetching

FetchingPolicy configures the provider to interpret the `data.secretKey.remoteRef.key` field in ExternalSecret as secret ID or secret name

=cut

1;
