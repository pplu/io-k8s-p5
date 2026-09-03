package IO::K8s::CertManager::V1::Certificate;
# ABSTRACT: A Certificate resource should be created to ensure an up to date and signed X.509 certificate is stored in the Kubernetes Secret resource named in `spec.secretName`.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cert-manager.io/v1',
    resource_plural => 'certificates';
with 'IO::K8s::Role::Namespaced', 'IO::K8s::Role::CertManaged';

k8s spec   => '+IO::K8s::CertManager::V1::CertificateSpec';
k8s status => '+IO::K8s::CertManager::V1::CertificateStatus';

=attr spec

Specification of the desired state of the Certificate resource.
https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

=attr status

Status of the Certificate.
This is set and managed automatically.
Read-only.
More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

1;
