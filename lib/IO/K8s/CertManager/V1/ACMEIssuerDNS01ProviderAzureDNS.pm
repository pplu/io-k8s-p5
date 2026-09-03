package IO::K8s::CertManager::V1::ACMEIssuerDNS01ProviderAzureDNS;
# ABSTRACT: Use the Microsoft Azure DNS API to manage DNS01 challenge records.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s clientID              => Str;
k8s clientSecretSecretRef => '+IO::K8s::CertManager::V1::SecretKeySelector';
k8s environment           => Str, { enum => [qw(AzurePublicCloud AzureChinaCloud AzureGermanCloud AzureUSGovernmentCloud)] };
k8s hostedZoneName        => Str;
k8s managedIdentity       => '+IO::K8s::CertManager::V1::AzureManagedIdentity';
k8s resourceGroupName     => Str, { required => 'schema' };
k8s subscriptionID        => Str, { required => 'schema' };
k8s tenantID              => Str;
k8s zoneType              => Str, { enum => [qw(AzurePublicZone AzurePrivateZone)] };

=attr clientID

Auth: Azure Service Principal:
The ClientID of the Azure Service Principal used to authenticate with Azure DNS.
If set, ClientSecret and TenantID must also be set.

=cut

=attr clientSecretSecretRef

Auth: Azure Service Principal:
A reference to a Secret containing the password associated with the Service Principal.
If set, ClientID and TenantID must also be set.

=cut

=attr environment

name of the Azure environment (default AzurePublicCloud)

=cut

=attr hostedZoneName

name of the DNS zone that should be used

=cut

=attr managedIdentity

Auth: Azure Workload Identity or Azure Managed Service Identity:
Settings to enable Azure Workload Identity or Azure Managed Service Identity
If set, ClientID, ClientSecret and TenantID must not be set.

=cut

=attr resourceGroupName

resource group the DNS zone is located in

=cut

=attr subscriptionID

ID of the Azure subscription

=cut

=attr tenantID

Auth: Azure Service Principal:
The TenantID of the Azure Service Principal used to authenticate with Azure DNS.
If set, ClientID and ClientSecret must also be set.

=cut

=attr zoneType

ZoneType determines which type of Azure DNS zone to use.

Valid values are:
  - AzurePublicZone  (default): Use a public Azure DNS zone.
  - AzurePrivateZone: Use an Azure Private DNS zone.

If not specified, AzurePublicZone is used.

Support for Azure Private DNS zones is currently
experimental and may change in future releases.

=cut

1;
