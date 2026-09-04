package IO::K8s::ExternalSecrets::V1::InfisicalAuth;
# ABSTRACT: Auth configures how the Operator authenticates with the Infisical API
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s awsAuthCredentials        => '+IO::K8s::ExternalSecrets::V1::AwsAuthCredentials';
k8s azureAuthCredentials      => '+IO::K8s::ExternalSecrets::V1::AzureAuthCredentials';
k8s gcpIamAuthCredentials     => '+IO::K8s::ExternalSecrets::V1::GcpIamAuthCredentials';
k8s gcpIdTokenAuthCredentials => '+IO::K8s::ExternalSecrets::V1::GcpIDTokenAuthCredentials';
k8s jwtAuthCredentials        => '+IO::K8s::ExternalSecrets::V1::JwtAuthCredentials';
k8s kubernetesAuthCredentials => '+IO::K8s::ExternalSecrets::V1::KubernetesAuthCredentials';
k8s ldapAuthCredentials       => '+IO::K8s::ExternalSecrets::V1::LdapAuthCredentials';
k8s ociAuthCredentials        => '+IO::K8s::ExternalSecrets::V1::OciAuthCredentials';
k8s tokenAuthCredentials      => '+IO::K8s::ExternalSecrets::V1::TokenAuthCredentials';
k8s universalAuthCredentials  => '+IO::K8s::ExternalSecrets::V1::UniversalAuthCredentials';

=attr awsAuthCredentials

AwsAuthCredentials represents the credentials for AWS authentication.

=cut

=attr azureAuthCredentials

AzureAuthCredentials represents the credentials for Azure authentication.

=cut

=attr gcpIamAuthCredentials

GcpIamAuthCredentials represents the credentials for GCP IAM authentication.

=cut

=attr gcpIdTokenAuthCredentials

GcpIDTokenAuthCredentials represents the credentials for GCP ID token authentication.

=cut

=attr jwtAuthCredentials

JwtAuthCredentials represents the credentials for JWT authentication.

=cut

=attr kubernetesAuthCredentials

KubernetesAuthCredentials represents the credentials for Kubernetes authentication.

=cut

=attr ldapAuthCredentials

LdapAuthCredentials represents the credentials for LDAP authentication.

=cut

=attr ociAuthCredentials

OciAuthCredentials represents the credentials for OCI authentication.

=cut

=attr tokenAuthCredentials

TokenAuthCredentials represents the credentials for access token-based authentication.

=cut

=attr universalAuthCredentials

UniversalAuthCredentials represents the client credentials for universal authentication.

=cut

1;
