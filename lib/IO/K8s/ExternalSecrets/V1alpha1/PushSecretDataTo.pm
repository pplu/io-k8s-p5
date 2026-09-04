package IO::K8s::ExternalSecrets::V1alpha1::PushSecretDataTo;
# ABSTRACT: PushSecretDataTo defines how to bulk-push secrets to providers without explicit per-key mappings.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conversionStrategy => Str, { enum => [qw(None ReverseUnicode)], default => 'None' };
k8s match              => '+IO::K8s::ExternalSecrets::V1alpha1::PushSecretDataToMatch';
k8s metadata           => Str, { preserve_unknown => 1 };
k8s remoteKey          => Str;
k8s rewrite            => ['+IO::K8s::ExternalSecrets::V1alpha1::PushSecretRewrite'];
k8s storeRef           => '+IO::K8s::ExternalSecrets::V1alpha1::PushSecretStoreRef';

=attr conversionStrategy

Used to define a conversion Strategy for the secret keys

=cut

=attr match

Match pattern for selecting keys from the source Secret.
If not specified, all keys are selected.

=cut

=attr metadata

Metadata is metadata attached to the secret.
The structure of metadata is provider specific, please look it up in the provider documentation.

=cut

=attr remoteKey

RemoteKey is the name of the single provider secret that will receive ALL
matched keys bundled as a JSON object (e.g. {"DB_HOST":"...","DB_USER":"..."}).
When set, per-key expansion is skipped and a single push is performed.
The provider's store prefix (if any) is still prepended to this value.
When not set, each matched key is pushed as its own individual provider secret.

=cut

=attr rewrite

Rewrite operations to transform keys before pushing to the provider.
Operations are applied sequentially.

=cut

=attr storeRef

StoreRef specifies which SecretStore to push to. Required.

=cut

1;
