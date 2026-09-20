package IO::K8s::ExternalSecrets::V1alpha1::GeneratorStateStatus;
# ABSTRACT: GeneratorStateStatus defines the observed state of a generator state resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conditions => ['+IO::K8s::ExternalSecrets::V1alpha1::GeneratorStateStatusCondition'];

=attr conditions

No description in the upstream schema.

=cut

1;
