package IO::K8s::CertManager::V1::ClusterIssuer;
# ABSTRACT: A ClusterIssuer represents a certificate issuing authority which can be referenced as part of `issuerRef` fields.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cert-manager.io/v1',
    resource_plural => 'clusterissuers';
with 'IO::K8s::Role::CertManaged';

k8s spec   => '+IO::K8s::CertManager::V1::IssuerSpec', { required => 'schema' };
k8s status => '+IO::K8s::CertManager::V1::IssuerStatus';

=attr spec

Desired state of the ClusterIssuer resource.

=cut

=attr status

Status of the ClusterIssuer. This is set and managed automatically.

=cut

1;
