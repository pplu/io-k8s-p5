package IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::WebhookConversion;
# ABSTRACT: WebhookConversion describes how to call a conversion webhook
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s clientConfig => 'Apiextensions::V1::WebhookClientConfig';

=attr clientConfig

clientConfig is the instructions for how to call the webhook if strategy is `Webhook`.

=cut

k8s conversionReviewVersions => [Str], 'required';

=attr conversionReviewVersions

conversionReviewVersions is an ordered list of preferred `ConversionReview` versions the Webhook expects. The API server will use the first version in the list which it supports. If none of the versions specified in this list are supported by API server, conversion will fail for the custom resource. If a persisted Webhook configuration specifies allowed versions and does not include any versions known to the API Server, calls to the webhook will fail.

=cut

1;
