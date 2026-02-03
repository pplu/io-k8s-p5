package IO::K8s::Api::Admissionregistration::V1::MutatingWebhookConfiguration;
# ABSTRACT: MutatingWebhookConfiguration describes the configuration of and admission webhook that accept or reject and may change the object.

use IO::K8s::APIObject;

=head1 DESCRIPTION

MutatingWebhookConfiguration describes the configuration of and admission webhook that accept or reject and may change the object.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s webhooks => ['Admissionregistration::V1::MutatingWebhook'];

=attr webhooks

Webhooks is a list of webhooks and the affected resources and operations.

=cut

1;
