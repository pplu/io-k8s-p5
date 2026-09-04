package IO::K8s::ExternalSecrets::V1::BeyondtrustWorkloadCredentialsAuth;
# ABSTRACT: Auth configures how the Operator authenticates with the BeyondTrust Workload Credentials API.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apikey => '+IO::K8s::ExternalSecrets::V1::BeyondtrustWorkloadCredentialsAuthSecretRef', { required => 'schema' };

=attr apikey

APIKey configures API token authentication for BeyondTrust Workload Credentials.
The token is retrieved from a Kubernetes secret and used as a Bearer token for API requests.

=cut

1;
