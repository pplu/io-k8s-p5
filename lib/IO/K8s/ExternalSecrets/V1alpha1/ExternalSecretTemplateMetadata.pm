package IO::K8s::ExternalSecrets::V1alpha1::ExternalSecretTemplateMetadata;
# ABSTRACT: ExternalSecretTemplateMetadata defines metadata fields for the Secret blueprint.
our $VERSION = '1.111';
use IO::K8s::Resource;

k8s annotations => HashRef[Str];
k8s finalizers  => [Str];
k8s labels      => HashRef[Str];

=attr annotations

No description in the upstream schema.

=cut

=attr finalizers

No description in the upstream schema.

=cut

=attr labels

No description in the upstream schema.

=cut

1;
