package IO::K8s::ExternalSecrets::V1::NTLMProtocol;
# ABSTRACT: NTLMProtocol configures the store to use NTLM for auth
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s passwordSecret => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s usernameSecret => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr passwordSecret

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr usernameSecret

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

1;
