package IO::K8s::ExternalSecrets::V1::OvhClientToken;
# ABSTRACT: OvhClientToken defines the configuration required to authenticate to OVHcloud's Secret Manager using a token.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s tokenSecretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr tokenSecretRef

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

1;
