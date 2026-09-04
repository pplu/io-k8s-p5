package IO::K8s::ExternalSecrets::V1alpha1::ClusterPushSecret;
# ABSTRACT: ClusterPushSecret is the Schema for the ClusterPushSecrets API that enables cluster-wide management of pushing Kubernetes secrets to external providers.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'external-secrets.io/v1alpha1',
    resource_plural => 'clusterpushsecrets';

k8s spec   => '+IO::K8s::ExternalSecrets::V1alpha1::ClusterPushSecretSpec';
k8s status => '+IO::K8s::ExternalSecrets::V1alpha1::ClusterPushSecretStatus';

=attr spec

ClusterPushSecretSpec defines the configuration for a ClusterPushSecret resource.

=cut

=attr status

ClusterPushSecretStatus contains the status information for the ClusterPushSecret resource.

=cut

1;
