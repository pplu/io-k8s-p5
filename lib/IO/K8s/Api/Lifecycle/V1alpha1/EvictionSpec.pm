package IO::K8s::Api::Lifecycle::V1alpha1::EvictionSpec;
# ABSTRACT: EvictionSpec is a specification of an Eviction.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s target => 'Lifecycle::V1alpha1::EvictionTarget', 'required';

=attr target

target contains a reference to an object (e.g. a pod) that should be evicted. This field is required and immutable.

=cut

1;
