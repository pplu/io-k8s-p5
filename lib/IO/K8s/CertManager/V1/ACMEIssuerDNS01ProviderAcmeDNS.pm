package IO::K8s::CertManager::V1::ACMEIssuerDNS01ProviderAcmeDNS;
# ABSTRACT: Use the 'ACME DNS' (https://github.com/joohoi/acme-dns) API to manage DNS01 challenge records.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s accountSecretRef => '+IO::K8s::CertManager::V1::SecretKeySelector', { required => 'schema' };
k8s host             => Str, { required => 'schema' };

=attr accountSecretRef

A reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr host

No description in the upstream schema.

=cut

1;
