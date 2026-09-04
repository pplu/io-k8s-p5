package IO::K8s::ExternalSecrets::V1::ChefAuthSecretRef;
# ABSTRACT: ChefAuthSecretRef holds secret references for chef server login credentials.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s privateKeySecretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr privateKeySecretRef

SecretKey is the Signing Key in PEM format, used for authentication.

=cut

1;
