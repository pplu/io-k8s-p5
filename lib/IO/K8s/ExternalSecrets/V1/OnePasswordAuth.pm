package IO::K8s::ExternalSecrets::V1::OnePasswordAuth;
# ABSTRACT: Auth defines the information necessary to authenticate against OnePassword Connect Server
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretRef => '+IO::K8s::ExternalSecrets::V1::OnePasswordAuthSecretRef', { required => 'schema' };

=attr secretRef

OnePasswordAuthSecretRef holds secret references for 1Password credentials.

=cut

1;
