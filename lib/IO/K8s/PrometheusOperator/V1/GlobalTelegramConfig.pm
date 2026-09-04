package IO::K8s::PrometheusOperator::V1::GlobalTelegramConfig;
# ABSTRACT: telegram defines the default Telegram config
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiURL => Str, { pattern => qr/^(http|https):\/\/.+$/ };

=attr apiURL

apiURL defines he default Telegram API URL.

It requires Alertmanager >= v0.24.0.

=cut

1;
