package IO::K8s::ExternalSecrets::V1::CSMAuth;
# ABSTRACT: CSMAuth contains a secretRef for credentials.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretRef => '+IO::K8s::ExternalSecrets::V1::CSMAuthSecretRef';

=attr secretRef

CSMAuthSecretRef holds secret references for Cloud.ru credentials.

=cut

1;
