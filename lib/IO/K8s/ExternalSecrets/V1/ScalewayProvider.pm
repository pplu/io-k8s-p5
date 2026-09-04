package IO::K8s::ExternalSecrets::V1::ScalewayProvider;
# ABSTRACT: Scaleway configures this store to sync secrets using the Scaleway provider.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s accessKey => '+IO::K8s::ExternalSecrets::V1::ScalewayProviderSecretRef', { required => 'schema' };
k8s apiUrl    => Str;
k8s projectId => Str, { required => 'schema' };
k8s region    => Str, { required => 'schema' };
k8s secretKey => '+IO::K8s::ExternalSecrets::V1::ScalewayProviderSecretRef', { required => 'schema' };

=attr accessKey

AccessKey is the non-secret part of the api key.

=cut

=attr apiUrl

APIURL is the url of the api to use. Defaults to https://api.scaleway.com

=cut

=attr projectId

ProjectID is the id of your project, which you can find in the console: https://console.scaleway.com/project/settings

=cut

=attr region

Region where your secrets are located: https://developers.scaleway.com/en/quickstart/#region-and-zone

=cut

=attr secretKey

SecretKey is the non-secret part of the api key.

=cut

1;
