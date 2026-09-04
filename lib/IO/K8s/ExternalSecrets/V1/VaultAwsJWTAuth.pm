package IO::K8s::ExternalSecrets::V1::VaultAwsJWTAuth;
# ABSTRACT: Specify a service account with IRSA enabled
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s serviceAccountRef => '+IO::K8s::ExternalSecrets::V1::ServiceAccountSelector';

=attr serviceAccountRef

ServiceAccountSelector is a reference to a ServiceAccount resource.

=cut

1;
