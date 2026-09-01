package IO::K8s::Api::Lifecycle::V1alpha1::EvictionRequestStatus;
# ABSTRACT: EvictionRequestStatus represents the last observed status of the eviction request.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conditions => ['Meta::V1::Condition'];

=attr conditions

conditions contain information about the eviction request.

EvictionRequest specific conditions are: TargetEvicted or Failed (managed by evictionrequest-controller). - Failed means that the eviction request is no longer being processed
  by any eviction responder. This can happen if the request is canceled or if no responder
  managed to evict the target (e.g. terminate or delete a pod).
- TargetEvicted means that the target has been evicted (e.g. a pod has been terminated or deleted).

These conditions can be reset if the eviction was unsuccessful and a new Eviction intent has been submitted.

The maximum length of the conditions list is 100.

=cut

k8s observedGeneration => Int;

=attr observedGeneration

observedGeneration is EvictionRequest's .metadata.generation observed by the evictionrequest-controller. The observed generation value cannot be negative and can only be incremented. The minimum value is 1. This field is managed by evictionrequest-controller.

=cut

1;
