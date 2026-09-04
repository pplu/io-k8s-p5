package IO::K8s::PrometheusOperator::V1::GlobalWebexConfig;
# ABSTRACT: webex defines the default configuration for Webex.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiURL => Str, { pattern => qr/^(http|https):\/\/.+$/ };

=attr apiURL

apiURL defines the is the default Webex API URL.

It requires Alertmanager >= v0.25.0.

=cut

1;
