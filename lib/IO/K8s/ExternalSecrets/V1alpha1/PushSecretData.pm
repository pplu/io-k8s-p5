package IO::K8s::ExternalSecrets::V1alpha1::PushSecretData;
# ABSTRACT: PushSecretData defines data to be pushed to the provider and associated metadata.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conversionStrategy => Str, { enum => [qw(None ReverseUnicode)], default => 'None' };
k8s match              => '+IO::K8s::ExternalSecrets::V1alpha1::PushSecretMatch', { required => 'schema' };
k8s metadata           => Str, { preserve_unknown => 1 };

=attr conversionStrategy

Used to define a conversion Strategy for the secret keys

=cut

=attr match

Match a given Secret Key to be pushed to the provider.

=cut

=attr metadata

Metadata is metadata attached to the secret.
The structure of metadata is provider specific, please look it up in the provider documentation.

=cut

1;
