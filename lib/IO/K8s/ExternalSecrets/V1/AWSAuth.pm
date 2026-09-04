package IO::K8s::ExternalSecrets::V1::AWSAuth;
# ABSTRACT: Auth defines the information necessary to authenticate against AWS if not set aws sdk will infer credentials from your environment see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s jwt       => '+IO::K8s::ExternalSecrets::V1::AWSJWTAuth';
k8s secretRef => '+IO::K8s::ExternalSecrets::V1::AWSAuthSecretRef';

=attr jwt

AWSJWTAuth stores reference to Authenticate against AWS using service account tokens.

=cut

=attr secretRef

AWSAuthSecretRef holds secret references for AWS credentials
both AccessKeyID and SecretAccessKey must be defined in order to properly authenticate.

=cut

1;
