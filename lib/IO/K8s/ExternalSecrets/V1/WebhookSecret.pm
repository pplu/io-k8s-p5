package IO::K8s::ExternalSecrets::V1::WebhookSecret;
# ABSTRACT: WebhookSecret defines a secret that will be passed to the webhook request.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name      => Str, { required => 'schema' };
k8s secretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr name

Name of this secret in templates

=cut

=attr secretRef

Secret ref to fill in credentials

=cut

1;
