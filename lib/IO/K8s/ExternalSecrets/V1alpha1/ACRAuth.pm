package IO::K8s::ExternalSecrets::V1alpha1::ACRAuth;
# ABSTRACT: ACRAuth defines the authentication methods for Azure Container Registry.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s managedIdentity  => '+IO::K8s::ExternalSecrets::V1alpha1::ACRManagedIdentity';
k8s servicePrincipal => '+IO::K8s::ExternalSecrets::V1alpha1::ACRServicePrincipal';
k8s workloadIdentity => '+IO::K8s::ExternalSecrets::V1alpha1::ACRWorkloadIdentity';

=attr managedIdentity

ManagedIdentity uses Azure Managed Identity to authenticate with Azure.

=cut

=attr servicePrincipal

ServicePrincipal uses Azure Service Principal credentials to authenticate with Azure.

=cut

=attr workloadIdentity

WorkloadIdentity uses Azure Workload Identity to authenticate with Azure.

=cut

1;
