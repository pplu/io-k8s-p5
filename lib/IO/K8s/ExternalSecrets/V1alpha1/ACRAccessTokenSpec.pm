package IO::K8s::ExternalSecrets::V1alpha1::ACRAccessTokenSpec;
# ABSTRACT: ACRAccessTokenSpec defines how to generate the access token e.g. how to authenticate and which registry to use.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth            => '+IO::K8s::ExternalSecrets::V1alpha1::ACRAuth', { required => 'schema' };
k8s environmentType => Str, { enum => [qw(PublicCloud USGovernmentCloud ChinaCloud GermanCloud AzureStackCloud)], default => 'PublicCloud' };
k8s registry        => Str, { required => 'schema' };
k8s scope           => Str;
k8s tenantId        => Str;

=attr auth

ACRAuth defines the authentication methods for Azure Container Registry.

=cut

=attr environmentType

EnvironmentType specifies the Azure cloud environment endpoints to use for
connecting and authenticating with Azure. By default, it points to the public cloud AAD endpoint.
The following endpoints are available, also see here: https://github.com/Azure/go-autorest/blob/main/autorest/azure/environments.go#L152
PublicCloud, USGovernmentCloud, ChinaCloud, GermanCloud

=cut

=attr registry

the domain name of the ACR registry
e.g. foobarexample.azurecr.io

=cut

=attr scope

Define the scope for the access token, e.g. pull/push access for a repository.
if not provided it will return a refresh token that has full scope.
Note: you need to pin it down to the repository level, there is no wildcard available.

examples:
repository:my-repository:pull,push
repository:my-repository:pull

see docs for details: https://docs.docker.com/registry/spec/auth/scope/

=cut

=attr tenantId

TenantID configures the Azure Tenant to send requests to. Required for ServicePrincipal auth type.

=cut

1;
