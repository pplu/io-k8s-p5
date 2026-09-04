package IO::K8s::ExternalSecrets::V1::VaultAwsAuthSecretRef;
# ABSTRACT: Specify credentials in a Secret object
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s accessKeyIDSecretRef     => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s secretAccessKeySecretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s sessionTokenSecretRef    => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';

=attr accessKeyIDSecretRef

The AccessKeyID is used for authentication

=cut

=attr secretAccessKeySecretRef

The SecretAccessKey is used for authentication

=cut

=attr sessionTokenSecretRef

The SessionToken used for authentication
This must be defined if AccessKeyID and SecretAccessKey are temporary credentials
see: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_use-resources.html

=cut

1;
