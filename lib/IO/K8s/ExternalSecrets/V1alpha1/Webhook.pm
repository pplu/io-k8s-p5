package IO::K8s::ExternalSecrets::V1alpha1::Webhook;
# ABSTRACT: Webhook connects to a third party API server to handle the secrets generation configuration parameters in spec.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'generators.external-secrets.io/v1alpha1',
    resource_plural => 'webhooks';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::ExternalSecrets::V1alpha1::WebhookSpec';

=attr spec

WebhookSpec controls the behavior of the external generator. Any body parameters should be passed to the server through the parameters field.

=cut

1;
