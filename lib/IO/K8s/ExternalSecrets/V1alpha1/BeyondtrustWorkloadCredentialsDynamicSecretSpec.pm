package IO::K8s::ExternalSecrets::V1alpha1::BeyondtrustWorkloadCredentialsDynamicSecretSpec;
# ABSTRACT: BeyondtrustWorkloadCredentialsDynamicSecretSpec defines the desired spec for BeyondtrustWorkloadCredentials dynamic generator.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s controller    => Str;
k8s provider      => '+IO::K8s::ExternalSecrets::V1::BeyondtrustWorkloadCredentialsProvider', { required => 'schema' };
k8s retrySettings => '+IO::K8s::ExternalSecrets::V1::SecretStoreRetrySettings';

=attr controller

Controller selects the controller that should handle this generator.
Leave empty to use the default controller.

=cut

=attr provider

Provider contains the BeyondtrustWorkloadCredentials provider configuration including authentication,
server connection details, and the folder path to the dynamic secret definition.
The folderPath should point to a dynamic secret definition that has been created in
BeyondTrust Workload Credentials (e.g., "production/aws-temp").
For setup details, see: https://docs.beyondtrust.com/bt-docs/docs/secrets-api

=cut

=attr retrySettings

RetrySettings configures exponential backoff for failed API requests.
If not specified, uses the default retry settings.

=cut

1;
