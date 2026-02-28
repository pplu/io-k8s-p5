package IO::K8s::Api::Core::V1::ContainerStateTerminated;
# ABSTRACT: ContainerStateTerminated is a terminated state of a container.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s containerID => Str;

=attr containerID

Container's ID in the format '<type>://<container_id>'

=cut

k8s exitCode => Int, 'required';

=attr exitCode

Exit status from the last termination of the container

=cut

k8s finishedAt => Time;

=attr finishedAt

Time at which the container last terminated

=cut

k8s message => Str;

=attr message

Message regarding the last termination of the container

=cut

k8s reason => Str;

=attr reason

(brief) reason from the last termination of the container

=cut

k8s signal => Int;

=attr signal

Signal from the last termination of the container

=cut

k8s startedAt => Time;

=attr startedAt

Time at which previous execution of the container started

=cut

1;
