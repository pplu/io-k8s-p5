package IO::K8s::Api::Core::V1::Probe;
# ABSTRACT: Probe describes a health check to be performed against a container to determine whether it is alive or ready to receive traffic.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s exec => 'Core::V1::ExecAction';

=attr exec

Exec specifies the action to take.

=cut

k8s failureThreshold => Int;

=attr failureThreshold

Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1.

=cut

k8s grpc => 'Core::V1::GRPCAction';

=attr grpc

GRPC specifies an action involving a GRPC port.

=cut

k8s httpGet => 'Core::V1::HTTPGetAction';

=attr httpGet

HTTPGet specifies the http request to perform.

=cut

k8s initialDelaySeconds => Int;

=attr initialDelaySeconds

Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes

=cut

k8s periodSeconds => Int;

=attr periodSeconds

How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1.

=cut

k8s successThreshold => Int;

=attr successThreshold

Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.

=cut

k8s tcpSocket => 'Core::V1::TCPSocketAction';

=attr tcpSocket

TCPSocket specifies an action involving a TCP port.

=cut

k8s terminationGracePeriodSeconds => Int;

=attr terminationGracePeriodSeconds

Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset.

=cut

k8s timeoutSeconds => Int;

=attr timeoutSeconds

Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes

=cut

1;
