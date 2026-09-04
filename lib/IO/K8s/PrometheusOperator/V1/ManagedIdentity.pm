package IO::K8s::PrometheusOperator::V1::ManagedIdentity;
# ABSTRACT: managedIdentity defines the Azure User-assigned Managed identity.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s clientId => Str;

=attr clientId

clientId defines the Azure User-assigned Managed identity.

For Prometheus >= 3.5.0 and Thanos >= 0.40.0, this field is allowed to be empty to support system-assigned managed identities.

=cut

1;
