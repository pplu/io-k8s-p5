package IO::K8s::Api::Core::V1::ContainerStateWaiting;
# ABSTRACT: ContainerStateWaiting is a waiting state of a container.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s message => Str;

=attr message

Message regarding why the container is not yet running.

=cut

k8s reason => Str;

=attr reason

(brief) reason the container is not yet running.

=cut

1;
