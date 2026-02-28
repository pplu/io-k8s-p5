package IO::K8s::Api::Core::V1::ContainerUser;
# ABSTRACT: ContainerUser represents user identity information
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s linux => 'Core::V1::LinuxContainerUser';

=attr linux

Linux holds user identity information initially attached to the first process of the containers in Linux. Note that the actual running identity can be changed if the process has enough privilege to do so.

=cut

1;
