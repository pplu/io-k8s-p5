package IO::K8s::ExternalSecrets::V1::ClusterExternalSecret;
# ABSTRACT: ClusterExternalSecret is the Schema for the clusterexternalsecrets API.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'external-secrets.io/v1',
    resource_plural => 'clusterexternalsecrets';

k8s spec   => '+IO::K8s::ExternalSecrets::V1::ClusterExternalSecretSpec';
k8s status => '+IO::K8s::ExternalSecrets::V1::ClusterExternalSecretStatus';

=attr spec

ClusterExternalSecretSpec defines the desired state of ClusterExternalSecret.

=cut

=attr status

ClusterExternalSecretStatus defines the observed state of ClusterExternalSecret.

=cut

1;
