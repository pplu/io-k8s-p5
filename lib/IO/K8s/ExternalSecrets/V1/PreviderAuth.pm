package IO::K8s::ExternalSecrets::V1::PreviderAuth;
# ABSTRACT: PreviderAuth contains a secretRef for credentials.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretRef => '+IO::K8s::ExternalSecrets::V1::PreviderAuthSecretRef';

=attr secretRef

PreviderAuthSecretRef holds secret references for Previder Vault credentials.

=cut

1;
