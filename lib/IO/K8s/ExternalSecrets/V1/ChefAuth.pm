package IO::K8s::ExternalSecrets::V1::ChefAuth;
# ABSTRACT: Auth defines the information necessary to authenticate against chef Server
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretRef => '+IO::K8s::ExternalSecrets::V1::ChefAuthSecretRef', { required => 'schema' };

=attr secretRef

ChefAuthSecretRef holds secret references for chef server login credentials.

=cut

1;
