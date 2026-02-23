package IO::K8s::Api::Admissionregistration::V1::MutatingWebhookConfiguration;
# ABSTRACT: MutatingWebhookConfiguration describes the configuration of and admission webhook that accept or reject and may change the object.
our $VERSION = '1.003';
use IO::K8s::APIObject;

=description

MutatingWebhookConfiguration describes the configuration of and admission webhook that accept or reject and may change the object.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s webhooks => ['Admissionregistration::V1::MutatingWebhook'];

=attr webhooks

Webhooks is a list of webhooks and the affected resources and operations.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#mutatingwebhookconfiguration-v1-admissionregistration.k8s.io>


=cut
1;
