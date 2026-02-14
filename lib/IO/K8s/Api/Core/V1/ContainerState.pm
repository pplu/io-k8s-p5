package IO::K8s::Api::Core::V1::ContainerState;
# ABSTRACT: ContainerState holds a possible state of container. Only one of its members may be specified. If none of them is specified, the default one is ContainerStateWaiting.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s running => 'Core::V1::ContainerStateRunning';

=attr running

Details about a running container

=cut

k8s terminated => 'Core::V1::ContainerStateTerminated';

=attr terminated

Details about a terminated container

=cut

k8s waiting => 'Core::V1::ContainerStateWaiting';

=attr waiting

Details about a waiting container

=cut

1;
