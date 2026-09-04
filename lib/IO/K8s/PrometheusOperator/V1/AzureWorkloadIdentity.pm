package IO::K8s::PrometheusOperator::V1::AzureWorkloadIdentity;
# ABSTRACT: workloadIdentity defines the Azure Workload Identity authentication.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s clientId => Str, { required => 'schema' };
k8s tenantId => Str, { required => 'schema' };

=attr clientId

clientId is the clientID of the Azure Active Directory application.

=cut

=attr tenantId

tenantId is the tenant ID of the Azure Active Directory application.

=cut

1;
