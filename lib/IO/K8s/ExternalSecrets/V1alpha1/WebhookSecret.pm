package IO::K8s::ExternalSecrets::V1alpha1::WebhookSecret;
# ABSTRACT: WebhookSecret defines a secret reference that will be used in webhook templates.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name      => Str, { required => 'schema' };
k8s secretRef => '+IO::K8s::ExternalSecrets::V1alpha1::SecretRef', { required => 'schema' };

=attr name

Name of this secret in templates

=cut

=attr secretRef

Secret ref to fill in credentials

=cut

1;
