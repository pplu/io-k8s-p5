package IO::K8s::PrometheusOperator::V1::GlobalVictorOpsConfig;
# ABSTRACT: victorops defines the default configuration for VictorOps.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiKey => 'Core::V1::ConfigMapKeySelector';
k8s apiURL => Str, { pattern => qr/^(http|https):\/\/.+$/ };

=attr apiKey

apiKey defines the default VictorOps API Key.

=cut

=attr apiURL

apiURL defines the default VictorOps API URL.

=cut

1;
