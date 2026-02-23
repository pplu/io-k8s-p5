package IO::K8s::Api::Admissionregistration::V1::ValidatingWebhookConfiguration;
# ABSTRACT: ValidatingWebhookConfiguration describes the configuration of and admission webhook that accept or reject and object without changing it.
our $VERSION = '1.003';
use IO::K8s::APIObject;

=description

ValidatingWebhookConfiguration describes the configuration of and admission webhook that accept or reject and object without changing it.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s webhooks => ['Admissionregistration::V1::ValidatingWebhook'];

=attr webhooks

Webhooks is a list of webhooks and the affected resources and operations.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#validatingwebhookconfiguration-v1-admissionregistration.k8s.io>


=cut
1;
