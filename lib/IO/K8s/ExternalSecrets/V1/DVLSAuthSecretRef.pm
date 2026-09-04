package IO::K8s::ExternalSecrets::V1::DVLSAuthSecretRef;
# ABSTRACT: SecretRef contains the Application ID and Application Secret for authentication.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s appId     => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s appSecret => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr appId

AppID is the reference to the secret containing the Application ID.

=cut

=attr appSecret

AppSecret is the reference to the secret containing the Application Secret.

=cut

1;
