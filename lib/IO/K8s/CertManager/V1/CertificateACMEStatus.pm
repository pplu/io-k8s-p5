package IO::K8s::CertManager::V1::CertificateACMEStatus;
# ABSTRACT: ACME stores information that is fetched from the ACME CA server.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s ari => '+IO::K8s::CertManager::V1::CertificateACMEARIStatus';

=attr ari

ARI stores the ACME Renewal Information that is fetched from the ACME server
in accordance with RFC 9773. This is only populated if the ARI feature gate is enabled.

=cut

1;
