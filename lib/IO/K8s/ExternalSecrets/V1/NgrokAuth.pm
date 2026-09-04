package IO::K8s::ExternalSecrets::V1::NgrokAuth;
# ABSTRACT: Auth configures how the ngrok provider authenticates with the ngrok API.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiKey => '+IO::K8s::ExternalSecrets::V1::NgrokProviderSecretRef';

=attr apiKey

APIKey is the API Key used to authenticate with ngrok. See https://ngrok.com/docs/api/#authentication

=cut

1;
