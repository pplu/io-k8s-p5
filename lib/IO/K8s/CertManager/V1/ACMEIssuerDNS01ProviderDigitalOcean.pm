package IO::K8s::CertManager::V1::ACMEIssuerDNS01ProviderDigitalOcean;
# ABSTRACT: Use the DigitalOcean DNS API to manage DNS01 challenge records.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s tokenSecretRef => '+IO::K8s::CertManager::V1::SecretKeySelector', { required => 'schema' };

=attr tokenSecretRef

A reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

1;
