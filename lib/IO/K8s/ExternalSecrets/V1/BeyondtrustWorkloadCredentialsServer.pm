package IO::K8s::ExternalSecrets::V1::BeyondtrustWorkloadCredentialsServer;
# ABSTRACT: Server configures the BeyondTrust Workload Credentials server connection details.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiUrl => Str, { required => 'schema' };
k8s siteId => Str, { required => 'schema' };

=attr apiUrl

APIURL is the base URL of your BeyondTrust Workload Credentials API server.
This should be the full URL to your BeyondTrust instance.
Example: https://api.beyondtrust.io/siie
For more information, see: https://docs.beyondtrust.com/bt-docs/docs/secrets-api#base-url

=cut

=attr siteId

SiteID is your BeyondTrust Workload Credentials site identifier (UUID format).
This identifier is unique to your BeyondTrust Workload Credentials instance.
You can find your Site ID in the BeyondTrust Workload Credentials admin console.
Example: a1b2c3d4-e5f6-4890-abcd-ef1234567890
For more information, see: https://docs.beyondtrust.com/bt-docs/docs/secrets-api

=cut

1;
