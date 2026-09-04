package IO::K8s::PrometheusOperator::V1::AzureSDK;
# ABSTRACT: sdk defines the Azure SDK config that is being used to authenticate.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s tenantId => Str, { pattern => qr/^[0-9a-zA-Z-.]+$/ };

=attr tenantId

tenantId defines the tenant ID of the azure active directory application that is being used to authenticate.

=cut

1;
