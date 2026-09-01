package IO::K8s::Api::Lifecycle::V1alpha1::Requester;
# ABSTRACT: Requester allows you to identify the entity, that requested the eviction of the target.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s intent => Str, 'required';

=attr intent

intent specifies the action that should be taken for the specified target.

- Eviction means that the requester is interested in the eviction of the target. - Withdrawn means that the requester is no longer interested in the eviction of the target.
  If all requesters' intents are withdrawn, the eviction will be canceled.
  Cancellation consequences:
  - Inactive responders will never run.
  - Active responders are expected to cancel the eviction.
  - Completed or Interrupted responders should not take any action.

=cut

k8s name => Str, 'required';

=attr name

name allows you to identify the entity, that requested the eviction of the target.

It must be a valid domain-prefixed key (such as "acme.io/foo"). This field must be unique for each requester. This field is required.

=cut

1;
