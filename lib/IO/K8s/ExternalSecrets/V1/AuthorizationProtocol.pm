package IO::K8s::ExternalSecrets::V1::AuthorizationProtocol;
# ABSTRACT: Auth specifies a authorization protocol.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s ntlm => '+IO::K8s::ExternalSecrets::V1::NTLMProtocol';

=attr ntlm

NTLMProtocol configures the store to use NTLM for auth

=cut

1;
