package IO::K8s::ExternalSecrets::V1::AzureKVProvider;
# ABSTRACT: AzureKV configures this store to sync secrets using Azure Key Vault provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s authSecretRef     => '+IO::K8s::ExternalSecrets::V1::AzureKVAuth';
k8s authType          => Str, { enum => [qw(ServicePrincipal ManagedIdentity WorkloadIdentity)], default => 'ServicePrincipal' };
k8s customCloudConfig => '+IO::K8s::ExternalSecrets::V1::AzureCustomCloudConfig';
k8s environmentType   => Str, { enum => [qw(PublicCloud USGovernmentCloud ChinaCloud GermanCloud AzureStackCloud)], default => 'PublicCloud' };
k8s identityId        => Str;
k8s serviceAccountRef => '+IO::K8s::ExternalSecrets::V1::ServiceAccountSelector';
k8s tenantId          => Str;
k8s useAzureSDK       => Bool, { default => 0 };
k8s vaultUrl          => Str, { required => 'schema' };

=attr authSecretRef

Auth configures how the operator authenticates with Azure. Required for ServicePrincipal auth type. Optional for WorkloadIdentity.

=cut

=attr authType

Auth type defines how to authenticate to the keyvault service.
Valid values are:
- "ServicePrincipal" (default): Using a service principal (tenantId, clientId, clientSecret)
- "ManagedIdentity": Using Managed Identity assigned to the pod (see aad-pod-identity)
- "WorkloadIdentity": Using a Kubernetes ServiceAccount federated with Entra ID

=cut

=attr customCloudConfig

CustomCloudConfig defines custom Azure endpoints for non-standard clouds.
Required when EnvironmentType is AzureStackCloud.
Optional for other environment types - useful for Azure China when using Workload Identity
with AKS, where the OIDC issuer (login.partner.microsoftonline.cn) differs from the
standard China Cloud endpoint (login.chinacloudapi.cn).
IMPORTANT: This feature REQUIRES UseAzureSDK to be set to true. Custom cloud
configuration is not supported with the legacy go-autorest SDK.

=cut

=attr environmentType

EnvironmentType specifies the Azure cloud environment endpoints to use for
connecting and authenticating with Azure. By default it points to the public cloud AAD endpoint.
The following endpoints are available, also see here: https://github.com/Azure/go-autorest/blob/main/autorest/azure/environments.go#L152
PublicCloud, USGovernmentCloud, ChinaCloud, GermanCloud, AzureStackCloud
Use AzureStackCloud when you need to configure custom Azure Stack Hub or Azure Stack Edge endpoints.

=cut

=attr identityId

If multiple Managed Identity is assigned to the pod, you can select the one to be used

=cut

=attr serviceAccountRef

ServiceAccountRef specified the service account
that should be used when authenticating with WorkloadIdentity.

=cut

=attr tenantId

TenantID configures the Azure Tenant to send requests to. Required for ServicePrincipal auth type. Optional for WorkloadIdentity.

=cut

=attr useAzureSDK

UseAzureSDK enables the use of the new Azure SDK for Go (azcore-based) instead of the legacy go-autorest SDK.
This is experimental and may have behavioral differences. Defaults to false (legacy SDK).

=cut

=attr vaultUrl

Vault Url from which the secrets to be fetched from.

=cut

1;
