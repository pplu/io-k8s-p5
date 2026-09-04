package IO::K8s::ExternalSecrets::V1::StoreGeneratorSourceRef;
# ABSTRACT: SourceRef points to a store or generator which contains secret values ready to use.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s generatorRef => 'Autoscaling::V1::CrossVersionObjectReference';
k8s storeRef     => '+IO::K8s::ExternalSecrets::V1::SecretStoreRef';

=attr generatorRef

GeneratorRef points to a generator custom resource.

=cut

=attr storeRef

SecretStoreRef defines which SecretStore to fetch the ExternalSecret data.

=cut

1;
