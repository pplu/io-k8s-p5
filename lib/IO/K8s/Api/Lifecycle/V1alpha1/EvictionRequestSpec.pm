package IO::K8s::Api::Lifecycle::V1alpha1::EvictionRequestSpec;
# ABSTRACT: EvictionRequestSpec is a specification of an EvictionRequest.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s intent => Str, 'required';

=attr intent

intent specifies the action that should be taken for the specified target.

- Eviction means that the requester is interested in the eviction of the target. - Withdrawn means that the requester is no longer interested in the eviction of the target.
  If all requesters' intents are withdrawn for a common target, the eviction will be canceled.
  Cancellation consequences:
  - Inactive responders will never run.
  - Active responders are expected to cancel the eviction.
  - Completed or Interrupted responders should not take any action.

=cut

k8s requester => Str, 'required';

=attr requester

requester allows you to identify the entity, that requested the eviction of the target.

It must be a valid domain-prefixed key (such as "acme.io/foo"). Domain names *.k8s.io and *.kubernetes.io are reserved. This field is required and immutable.

=cut

k8s target => 'Lifecycle::V1alpha1::EvictionRequestTarget', 'required';

=attr target

target contains a reference to an object (e.g. a pod) that should be evicted. This field is required and immutable.

=cut

1;
