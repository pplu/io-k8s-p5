package IO::K8s::CertManager::V1::CertificateRequest;
# ABSTRACT: A CertificateRequest is used to request a signed certificate from one of the configured issuers.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cert-manager.io/v1',
    resource_plural => 'certificaterequests';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::CertManager::V1::CertificateRequestSpec';
k8s status => '+IO::K8s::CertManager::V1::CertificateRequestStatus';

=attr spec

Specification of the desired state of the CertificateRequest resource.
https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

=attr status

Status of the CertificateRequest.
This is set and managed automatically.
Read-only.
More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

1;
