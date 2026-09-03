package IO::K8s::CertManager::V1::VaultAWSAuth;
# ABSTRACT: AWS authenticates with Vault using AWS IAM authentication.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s iamRoleArn        => Str;
k8s mountPath         => Str;
k8s region            => Str;
k8s role              => Str, { required => 'schema' };
k8s serviceAccountRef => '+IO::K8s::CertManager::V1::ServiceAccountRef';
k8s vaultHeaderValue  => Str;

=attr iamRoleArn

The ARN of the AWS IAM role to assume using the Kubernetes service account
token. Required when using IRSA (serviceAccountRef is set).
This role must have a trust policy that allows the OIDC provider to assume it.

=cut

=attr mountPath

The Vault mountPath here is the mount path to use when authenticating with
Vault. For example, setting a value to `/v1/auth/foo`, will use the path
`/v1/auth/foo/login` to authenticate with Vault. If unspecified, the
default value "/v1/auth/aws" will be used.

=cut

=attr region

The AWS region to use for authentication. If not specified, the region
will be determined from AWS_REGION or AWS_DEFAULT_REGION environment
variables, falling back to "us-east-1" if not set.

=cut

=attr role

A required field containing the Vault Role to assume when authenticating.

=cut

=attr serviceAccountRef

A reference to a service account that will be used to request a web identity
token for IRSA (IAM Roles for Service Accounts) authentication.

=cut

=attr vaultHeaderValue

The Vault header value to include in the STS signing request.
This is used to prevent replay attacks.

=cut

1;
