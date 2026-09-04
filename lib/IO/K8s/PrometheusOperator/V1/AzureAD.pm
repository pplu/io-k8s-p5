package IO::K8s::PrometheusOperator::V1::AzureAD;
# ABSTRACT: azureAd for the URL.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s cloud            => Str, { enum => [qw(AzureChina AzureGovernment AzurePublic)] };
k8s managedIdentity  => '+IO::K8s::PrometheusOperator::V1::ManagedIdentity';
k8s oauth            => '+IO::K8s::PrometheusOperator::V1::AzureOAuth';
k8s scope            => Str, { pattern => qr/^[\w\s:\/.\\-]+$/ };
k8s sdk              => '+IO::K8s::PrometheusOperator::V1::AzureSDK';
k8s workloadIdentity => '+IO::K8s::PrometheusOperator::V1::AzureWorkloadIdentity';

=attr cloud

cloud defines the Azure Cloud. Options are 'AzurePublic', 'AzureChina', or 'AzureGovernment'.

=cut

=attr managedIdentity

managedIdentity defines the Azure User-assigned Managed identity.
Cannot be set at the same time as `oauth`, `sdk` or `workloadIdentity`.

=cut

=attr oauth

oauth defines the oauth config that is being used to authenticate.
Cannot be set at the same time as `managedIdentity`, `sdk` or `workloadIdentity`.

It requires Prometheus >= v2.48.0 or Thanos >= v0.31.0.

=cut

=attr scope

scope is the custom OAuth 2.0 scope to request when acquiring tokens.
It requires Prometheus >= 3.9.0. Currently not supported by Thanos.

=cut

=attr sdk

sdk defines the Azure SDK config that is being used to authenticate.
See https://learn.microsoft.com/en-us/azure/developer/go/azure-sdk-authentication
Cannot be set at the same time as `oauth`, `managedIdentity` or `workloadIdentity`.

It requires Prometheus >= v2.52.0 or Thanos >= v0.36.0.

=cut

=attr workloadIdentity

workloadIdentity defines the Azure Workload Identity authentication.
Cannot be set at the same time as `oauth`, `managedIdentity`, or `sdk`.

It requires Prometheus >= 3.7.0. Currently not supported by Thanos.

=cut

1;
