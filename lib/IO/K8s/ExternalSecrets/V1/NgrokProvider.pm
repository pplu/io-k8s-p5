package IO::K8s::ExternalSecrets::V1::NgrokProvider;
# ABSTRACT: Ngrok configures this store to sync secrets using the ngrok provider.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiUrl => Str, { default => 'https://api.ngrok.com' };
k8s auth   => '+IO::K8s::ExternalSecrets::V1::NgrokAuth', { required => 'schema' };
k8s vault  => '+IO::K8s::ExternalSecrets::V1::NgrokVault', { required => 'schema' };

=attr apiUrl

APIURL is the URL of the ngrok API.

=cut

=attr auth

Auth configures how the ngrok provider authenticates with the ngrok API.

=cut

=attr vault

Vault configures the ngrok vault to sync secrets with.

=cut

1;
