package IO::K8s::PrometheusOperator::V1::GlobalMattermostConfig;
# ABSTRACT: mattermost defines the default Mattermost Config
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s webhookURL => 'Core::V1::ConfigMapKeySelector';

=attr webhookURL

webhookURL defines the default Mattermost Webhook URL.

It requires Alertmanager >= v0.32.0.

=cut

1;
