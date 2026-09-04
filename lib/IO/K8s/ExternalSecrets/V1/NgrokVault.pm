package IO::K8s::ExternalSecrets::V1::NgrokVault;
# ABSTRACT: Vault configures the ngrok vault to sync secrets with.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name => Str, { required => 'schema' };

=attr name

Name is the name of the ngrok vault to sync secrets with.

=cut

1;
