package IO::K8s::PrometheusOperator::V1::GlobalWeChatConfig;
# ABSTRACT: wechat defines the default WeChat Config
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiCorpID => Str;
k8s apiSecret => 'Core::V1::ConfigMapKeySelector';
k8s apiURL    => Str, { pattern => qr/^(http|https):\/\/.+$/ };

=attr apiCorpID

apiCorpID defines the default WeChat API Corporate ID.

=cut

=attr apiSecret

apiSecret defines the default WeChat API Secret.

=cut

=attr apiURL

apiURL defines he default WeChat API URL.
The default value is "https://qyapi.weixin.qq.com/cgi-bin/"

=cut

1;
