package IO::K8s::ExternalSecrets::V1alpha1::ClusterGeneratorGenerator;
# ABSTRACT: Generator the spec for this generator, must match the kind.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s acrAccessTokenSpec => '+IO::K8s::ExternalSecrets::V1alpha1::ACRAccessTokenSpec';
k8s beyondtrustWorkloadCredentialsDynamicSecretSpec => '+IO::K8s::ExternalSecrets::V1alpha1::BeyondtrustWorkloadCredentialsDynamicSecretSpec';
k8s cloudsmithAccessTokenSpec => '+IO::K8s::ExternalSecrets::V1alpha1::CloudsmithAccessTokenSpec';
k8s ecrAuthorizationTokenSpec => '+IO::K8s::ExternalSecrets::V1alpha1::ECRAuthorizationTokenSpec';
k8s fakeSpec => '+IO::K8s::ExternalSecrets::V1alpha1::FakeSpec';
k8s gcrAccessTokenSpec => '+IO::K8s::ExternalSecrets::V1alpha1::GCRAccessTokenSpec';
k8s githubAccessTokenSpec => '+IO::K8s::ExternalSecrets::V1alpha1::GithubAccessTokenSpec';
k8s gitlabDeployTokenSpec => '+IO::K8s::ExternalSecrets::V1alpha1::GitlabDeployTokenSpec';
k8s grafanaSpec => '+IO::K8s::ExternalSecrets::V1alpha1::GrafanaSpec';
k8s mfaSpec => '+IO::K8s::ExternalSecrets::V1alpha1::MFASpec';
k8s passwordSpec => '+IO::K8s::ExternalSecrets::V1alpha1::PasswordSpec';
k8s quayAccessTokenSpec => '+IO::K8s::ExternalSecrets::V1alpha1::QuayAccessTokenSpec';
k8s sshKeySpec => '+IO::K8s::ExternalSecrets::V1alpha1::SSHKeySpec';
k8s stsSessionTokenSpec => '+IO::K8s::ExternalSecrets::V1alpha1::STSSessionTokenSpec';
k8s uuidSpec => '+IO::K8s::ExternalSecrets::V1alpha1::UUIDSpec';
k8s vaultDynamicSecretSpec => '+IO::K8s::ExternalSecrets::V1alpha1::VaultDynamicSecretSpec';
k8s webhookSpec => '+IO::K8s::ExternalSecrets::V1alpha1::WebhookSpec';

=attr acrAccessTokenSpec

ACRAccessTokenSpec defines how to generate the access token
e.g. how to authenticate and which registry to use.
see: https://github.com/Azure/acr/blob/main/docs/AAD-OAuth.md#overview

=cut

=attr beyondtrustWorkloadCredentialsDynamicSecretSpec

BeyondtrustWorkloadCredentialsDynamicSecretSpec defines the desired spec for BeyondtrustWorkloadCredentials dynamic generator.
This generator enables obtaining temporary, short-lived credentials from BeyondTrust Workload Credentials.
For more information, see: https://docs.beyondtrust.com/bt-docs/docs/secrets-api

=cut

=attr cloudsmithAccessTokenSpec

CloudsmithAccessTokenSpec defines the configuration for generating a Cloudsmith access token using OIDC authentication.

=cut

=attr ecrAuthorizationTokenSpec

ECRAuthorizationTokenSpec defines the desired state to generate an AWS ECR authorization token.

=cut

=attr fakeSpec

FakeSpec contains the static data.

=cut

=attr gcrAccessTokenSpec

GCRAccessTokenSpec defines the desired state to generate a Google Container Registry access token.

=cut

=attr githubAccessTokenSpec

GithubAccessTokenSpec defines the desired state to generate a GitHub access token.

=cut

=attr gitlabDeployTokenSpec

GitlabDeployTokenSpec defines the desired state to generate a GitLab deploy token.

=cut

=attr grafanaSpec

GrafanaSpec controls the behavior of the grafana generator.

=cut

=attr mfaSpec

MFASpec controls the behavior of the mfa generator.

=cut

=attr passwordSpec

PasswordSpec controls the behavior of the password generator.

=cut

=attr quayAccessTokenSpec

QuayAccessTokenSpec defines the desired state to generate a Quay access token.

=cut

=attr sshKeySpec

SSHKeySpec controls the behavior of the ssh key generator.

=cut

=attr stsSessionTokenSpec

STSSessionTokenSpec defines the desired state to generate an AWS STS session token.

=cut

=attr uuidSpec

UUIDSpec controls the behavior of the uuid generator.

=cut

=attr vaultDynamicSecretSpec

VaultDynamicSecretSpec defines the desired spec of VaultDynamicSecret.

=cut

=attr webhookSpec

WebhookSpec controls the behavior of the external generator. Any body parameters should be passed to the server through the parameters field.

=cut

1;
