package IO::K8s::ExternalSecrets::V1alpha1::ClusterGenerator;
# ABSTRACT: ClusterGenerator represents a cluster-wide generator which can be referenced as part of `generatorRef` fields.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'generators.external-secrets.io/v1alpha1',
    resource_plural => 'clustergenerators';

k8s spec => '+IO::K8s::ExternalSecrets::V1alpha1::ClusterGeneratorSpec';

=attr spec

ClusterGeneratorSpec defines the desired state of a ClusterGenerator.

=cut

1;
