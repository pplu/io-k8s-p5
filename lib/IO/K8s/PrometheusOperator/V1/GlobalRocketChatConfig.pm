package IO::K8s::PrometheusOperator::V1::GlobalRocketChatConfig;
# ABSTRACT: rocketChat defines the default configuration for Rocket Chat.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiURL  => Str, { pattern => qr/^(http|https):\/\/.+$/ };
k8s token   => 'Core::V1::ConfigMapKeySelector';
k8s tokenID => 'Core::V1::ConfigMapKeySelector';

=attr apiURL

apiURL defines the default Rocket Chat API URL.

It requires Alertmanager >= v0.28.0.

=cut

=attr token

token defines the default Rocket Chat token.

It requires Alertmanager >= v0.28.0.

=cut

=attr tokenID

tokenID defines the default Rocket Chat Token ID.

It requires Alertmanager >= v0.28.0.

=cut

1;
