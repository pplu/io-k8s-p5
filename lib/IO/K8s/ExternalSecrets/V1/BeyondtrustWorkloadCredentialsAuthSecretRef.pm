package IO::K8s::ExternalSecrets::V1::BeyondtrustWorkloadCredentialsAuthSecretRef;
# ABSTRACT: APIKey configures API token authentication for BeyondTrust Workload Credentials.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s token => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr token

Token references the Kubernetes secret containing the BeyondTrust Workload Credentials API token.
The secret should contain the API key used to authenticate with BeyondTrust Workload Credentials.
Create an API token in your BeyondTrust Workload Credentials console and store it in a Kubernetes secret.
For details on creating API tokens, see: https://docs.beyondtrust.com/bt-docs/docs/secrets-api#authentication

=cut

1;
