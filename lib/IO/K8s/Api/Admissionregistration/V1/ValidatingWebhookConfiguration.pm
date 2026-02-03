package IO::K8s::Api::Admissionregistration::V1::ValidatingWebhookConfiguration;
# ABSTRACT: ValidatingWebhookConfiguration describes the configuration of and admission webhook that accept or reject and object without changing it.

use IO::K8s::APIObject;

=head1 DESCRIPTION

ValidatingWebhookConfiguration describes the configuration of and admission webhook that accept or reject and object without changing it.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s webhooks => ['Admissionregistration::V1::ValidatingWebhook'];

=attr webhooks

Webhooks is a list of webhooks and the affected resources and operations.

=cut

1;
