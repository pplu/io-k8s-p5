package IO::K8s::ExternalSecrets::V1::OvhClientMTLS;
# ABSTRACT: OvhClientMTLS defines the configuration required to authenticate to OVHcloud's Secret Manager using mTLS.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s caBundle      => Str;
k8s caProvider    => '+IO::K8s::ExternalSecrets::V1::CAProvider';
k8s certSecretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s keySecretRef  => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr caBundle

No description in the upstream schema.

=cut

=attr caProvider

CAProvider provides a custom certificate authority for accessing the provider's store.
The CAProvider points to a Secret or ConfigMap resource that contains a PEM-encoded certificate.

=cut

=attr certSecretRef

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr keySecretRef

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

1;
