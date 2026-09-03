package IO::K8s::CertManager::V1::ACMEIssuerDNS01ProviderAkamai;
# ABSTRACT: Use the Akamai DNS zone management API to manage DNS01 challenge records.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s accessTokenSecretRef  => '+IO::K8s::CertManager::V1::SecretKeySelector', { required => 'schema' };
k8s clientSecretSecretRef => '+IO::K8s::CertManager::V1::SecretKeySelector', { required => 'schema' };
k8s clientTokenSecretRef  => '+IO::K8s::CertManager::V1::SecretKeySelector', { required => 'schema' };
k8s serviceConsumerDomain => Str, { required => 'schema' };

=attr accessTokenSecretRef

A reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr clientSecretSecretRef

A reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr clientTokenSecretRef

A reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr serviceConsumerDomain

No description in the upstream schema.

=cut

1;
