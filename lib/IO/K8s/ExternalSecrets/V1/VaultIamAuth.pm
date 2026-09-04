package IO::K8s::ExternalSecrets::V1::VaultIamAuth;
# ABSTRACT: Iam authenticates with vault by passing a special AWS request signed with AWS IAM credentials AWS IAM authentication method
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s externalID          => Str;
k8s jwt                 => '+IO::K8s::ExternalSecrets::V1::VaultAwsJWTAuth';
k8s path                => Str;
k8s region              => Str;
k8s role                => Str;
k8s secretRef           => '+IO::K8s::ExternalSecrets::V1::VaultAwsAuthSecretRef';
k8s vaultAwsIamServerID => Str;
k8s vaultRole           => Str, { required => 'schema' };

=attr externalID

AWS External ID set on assumed IAM roles

=cut

=attr jwt

Specify a service account with IRSA enabled

=cut

=attr path

Path where the AWS auth method is enabled in Vault, e.g: "aws"

=cut

=attr region

AWS region

=cut

=attr role

This is the AWS role to be assumed before talking to vault

=cut

=attr secretRef

Specify credentials in a Secret object

=cut

=attr vaultAwsIamServerID

X-Vault-AWS-IAM-Server-ID is an additional header used by Vault IAM auth method to mitigate against different types of replay attacks. More details here: https://developer.hashicorp.com/vault/docs/auth/aws

=cut

=attr vaultRole

Vault Role. In vault, a role describes an identity with a set of permissions, groups, or policies you want to attach a user of the secrets engine

=cut

1;
