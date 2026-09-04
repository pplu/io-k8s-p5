package IO::K8s::ExternalSecrets::V1::CSMAuthSecretRef;
# ABSTRACT: CSMAuthSecretRef holds secret references for Cloud.ru credentials.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s accessKeyIDSecretRef     => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s accessKeySecretSecretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr accessKeyIDSecretRef

The AccessKeyID is used for authentication

=cut

=attr accessKeySecretSecretRef

The AccessKeySecret is used for authentication

=cut

1;
