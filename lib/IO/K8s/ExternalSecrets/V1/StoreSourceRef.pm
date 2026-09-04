package IO::K8s::ExternalSecrets::V1::StoreSourceRef;
# ABSTRACT: SourceRef allows you to override the source from which the value will be pulled.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s generatorRef => 'Autoscaling::V1::CrossVersionObjectReference';
k8s storeRef     => '+IO::K8s::ExternalSecrets::V1::SecretStoreRef';

=attr generatorRef

GeneratorRef points to a generator custom resource.

Deprecated: The generatorRef is not implemented in .data[].
this will be removed with v1.

=cut

=attr storeRef

SecretStoreRef defines which SecretStore to fetch the ExternalSecret data.

=cut

1;
