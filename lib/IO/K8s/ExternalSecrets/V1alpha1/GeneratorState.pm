package IO::K8s::ExternalSecrets::V1alpha1::GeneratorState;
# ABSTRACT: GeneratorState represents the state created and managed by a generator resource.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'generators.external-secrets.io/v1alpha1',
    resource_plural => 'generatorstates';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::ExternalSecrets::V1alpha1::GeneratorStateSpec';
k8s status => '+IO::K8s::ExternalSecrets::V1alpha1::GeneratorStateStatus';

=attr spec

GeneratorStateSpec defines the desired state of a generator state resource.

=cut

=attr status

GeneratorStateStatus defines the observed state of a generator state resource.

=cut

1;
