package IO::K8s::ExternalSecrets::V1::AWSJWTAuth;
# ABSTRACT: AWSJWTAuth stores reference to Authenticate against AWS using service account tokens.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s serviceAccountRef => '+IO::K8s::ExternalSecrets::V1::ServiceAccountSelector';

=attr serviceAccountRef

ServiceAccountSelector is a reference to a ServiceAccount resource.

=cut

1;
