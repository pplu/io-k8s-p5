package IO::K8s::ExternalSecrets::V1::VolcengineAuthSecretRef;
# ABSTRACT: SecretRef defines the static credentials to use for authentication.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s accessKeyID     => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s secretAccessKey => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s token           => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';

=attr accessKeyID

AccessKeyID is the reference to the secret containing the Access Key ID.

=cut

=attr secretAccessKey

SecretAccessKey is the reference to the secret containing the Secret Access Key.

=cut

=attr token

Token is the reference to the secret containing the STS(Security Token Service) Token.

=cut

1;
