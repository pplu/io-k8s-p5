package IO::K8s::ExternalSecrets::V1::BeyondtrustWorkloadCredentialsProvider;
# ABSTRACT: BeyondtrustWorkloadCredentials configures this store to sync secrets using the BeyondTrust Workload Credentials provider.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth       => '+IO::K8s::ExternalSecrets::V1::BeyondtrustWorkloadCredentialsAuth', { required => 'schema' };
k8s caBundle   => Str;
k8s caProvider => '+IO::K8s::ExternalSecrets::V1::CAProvider';
k8s folderPath => Str;
k8s server     => '+IO::K8s::ExternalSecrets::V1::BeyondtrustWorkloadCredentialsServer', { required => 'schema' };

=attr auth

Auth configures how the Operator authenticates with the BeyondTrust Workload Credentials API.
Currently supports API key authentication via Kubernetes secret reference.
For authentication setup, see: https://docs.beyondtrust.com/bt-docs/docs/secrets-api#authentication

=cut

=attr caBundle

CABundle is a base64-encoded CA certificate used to validate the BeyondTrust Workload Credentials API TLS certificate.
Use this when your BeyondTrust instance uses a self-signed certificate or internal CA.
If not set, the system's trusted root certificates are used.

=cut

=attr caProvider

CAProvider points to a Secret or ConfigMap containing a PEM-encoded CA certificate.
This is used to validate the BeyondTrust Workload Credentials API TLS certificate.
Use this as an alternative to CABundle when you want to reference an existing Kubernetes resource.

=cut

=attr folderPath

FolderPath specifies the default folder path for secret retrieval.
Secrets will be fetched from this folder unless overridden in the ExternalSecret spec.
Example: "production/database" or "dev/api-keys"
Leave empty to retrieve secrets from the root folder.
For folder organization, see: https://docs.beyondtrust.com/bt-docs/docs/secrets-api#folders

=cut

=attr server

Server configures the BeyondTrust Workload Credentials server connection details.
Includes the API URL and Site ID for your BeyondTrust instance.
For API reference, see: https://docs.beyondtrust.com/bt-docs/docs/secrets-api

=cut

1;
