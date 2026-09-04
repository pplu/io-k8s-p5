package IO::K8s::ExternalSecrets::V1::YandexAuth;
# ABSTRACT: Auth defines the information necessary to authenticate against Yandex.Cloud
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s authorizedKeySecretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';

=attr authorizedKeySecretRef

The authorized key used for authentication

=cut

1;
