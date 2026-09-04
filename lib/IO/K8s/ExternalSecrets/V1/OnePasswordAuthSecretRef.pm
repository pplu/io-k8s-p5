package IO::K8s::ExternalSecrets::V1::OnePasswordAuthSecretRef;
# ABSTRACT: OnePasswordAuthSecretRef holds secret references for 1Password credentials.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s connectTokenSecretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr connectTokenSecretRef

The ConnectToken is used for authentication to a 1Password Connect Server.

=cut

1;
