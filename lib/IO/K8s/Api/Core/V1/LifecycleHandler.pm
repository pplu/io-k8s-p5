package IO::K8s::Api::Core::V1::LifecycleHandler;
# ABSTRACT: LifecycleHandler defines a specific action that should be taken in a lifecycle hook. One and only one of the fields, except TCPSocket must be specified.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s exec => 'Core::V1::ExecAction';

=attr exec

Exec specifies the action to take.

=cut

k8s httpGet => 'Core::V1::HTTPGetAction';

=attr httpGet

HTTPGet specifies the http request to perform.

=cut

k8s sleep => 'Core::V1::SleepAction';

=attr sleep

Sleep represents the duration that the container should sleep before being terminated.

=cut

k8s tcpSocket => 'Core::V1::TCPSocketAction';

=attr tcpSocket

Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept for the backward compatibility. There are no validation of this field and lifecycle hooks will fail in runtime when tcp handler is specified.

=cut

1;
