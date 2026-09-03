package IO::K8s::CertManager::V1::AzureManagedIdentity;
# ABSTRACT: Auth: Azure Workload Identity or Azure Managed Service Identity: Settings to enable Azure Workload Identity or Azure Managed Service Identity If set, ClientID, ClientSecret and TenantID must not be set.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s clientID   => Str;
k8s resourceID => Str;
k8s tenantID   => Str;

=attr clientID

client ID of the managed identity, cannot be used at the same time as resourceID

=cut

=attr resourceID

resource ID of the managed identity, cannot be used at the same time as clientID
Cannot be used for Azure Managed Service Identity

=cut

=attr tenantID

tenant ID of the managed identity, cannot be used at the same time as resourceID

=cut

1;
