package IO::K8s::PrometheusOperator::V1::AlertmanagerGlobalConfig;
# ABSTRACT: global defines the global parameters of the Alertmanager configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s httpConfig     => '+IO::K8s::PrometheusOperator::V1::HTTPConfigWithProxy';
k8s jira           => '+IO::K8s::PrometheusOperator::V1::GlobalJiraConfig';
k8s mattermost     => '+IO::K8s::PrometheusOperator::V1::GlobalMattermostConfig';
k8s opsGenieApiKey => 'Core::V1::ConfigMapKeySelector';
k8s opsGenieApiUrl => 'Core::V1::ConfigMapKeySelector';
k8s pagerdutyUrl   => Str, { pattern => qr/^(http|https):\/\/.+$/ };
k8s resolveTimeout => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s rocketChat     => '+IO::K8s::PrometheusOperator::V1::GlobalRocketChatConfig';
k8s slackApiUrl    => 'Core::V1::ConfigMapKeySelector';
k8s smtp           => '+IO::K8s::PrometheusOperator::V1::GlobalSMTPConfig';
k8s telegram       => '+IO::K8s::PrometheusOperator::V1::GlobalTelegramConfig';
k8s victorops      => '+IO::K8s::PrometheusOperator::V1::GlobalVictorOpsConfig';
k8s webex          => '+IO::K8s::PrometheusOperator::V1::GlobalWebexConfig';
k8s wechat         => '+IO::K8s::PrometheusOperator::V1::GlobalWeChatConfig';

=attr httpConfig

httpConfig defines the default HTTP configuration.

=cut

=attr jira

jira defines the default configuration for Jira.

=cut

=attr mattermost

mattermost defines the default Mattermost Config

=cut

=attr opsGenieApiKey

opsGenieApiKey defines the default OpsGenie API Key.

=cut

=attr opsGenieApiUrl

opsGenieApiUrl defines the default OpsGenie API URL.

=cut

=attr pagerdutyUrl

pagerdutyUrl defines the default Pagerduty URL.

=cut

=attr resolveTimeout

resolveTimeout defines the default value used by alertmanager if the alert does
not include EndsAt, after this time passes it can declare the alert as resolved if it has not been updated.
This has no impact on alerts from Prometheus, as they always include EndsAt.

=cut

=attr rocketChat

rocketChat defines the default configuration for Rocket Chat.

=cut

=attr slackApiUrl

slackApiUrl defines the default Slack API URL.

=cut

=attr smtp

smtp defines global SMTP parameters.

=cut

=attr telegram

telegram defines the default Telegram config

=cut

=attr victorops

victorops defines the default configuration for VictorOps.

=cut

=attr webex

webex defines the default configuration for Webex.

=cut

=attr wechat

wechat defines the default WeChat Config

=cut

1;
