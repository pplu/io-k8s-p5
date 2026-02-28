package IO::K8s::Api::Core::V1::ContainerStateRunning;
# ABSTRACT: ContainerStateRunning is a running state of a container.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s startedAt => Time;

=attr startedAt

Time at which the container was last (re-)started

=cut

1;
