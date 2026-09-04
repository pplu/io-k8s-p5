package IO::K8s::ExternalSecrets::V1::WebhookResult;
# ABSTRACT: Result formatting
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s jsonPath => Str;

=attr jsonPath

Json path of return value

=cut

1;
