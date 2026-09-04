package IO::K8s::ExternalSecrets::V1::AwsCredentialsConfig;
# ABSTRACT: awsSecurityCredentials is for configuring AWS region and credentials to use for obtaining the access token, when using the AWS metadata server is not an option.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s awsCredentialsSecretRef => 'Core::V1::SecretReference', { required => 'schema' };
k8s region                  => Str, { required => 'schema', pattern => qr/^[a-z0-9-]+$/ };

=attr awsCredentialsSecretRef

awsCredentialsSecretRef is the reference to the secret which holds the AWS credentials.
Secret should be created with below names for keys
- aws_access_key_id: Access Key ID, which is the unique identifier for the AWS account or the IAM user.
- aws_secret_access_key: Secret Access Key, which is used to authenticate requests made to AWS services.
- aws_session_token: Session Token, is the short-lived token to authenticate requests made to AWS services.

=cut

=attr region

region is for configuring the AWS region to be used.

=cut

1;
