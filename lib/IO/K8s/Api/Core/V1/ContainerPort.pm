package IO::K8s::Api::Core::V1::ContainerPort;
# ABSTRACT: ContainerPort represents a network port in a single container.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s containerPort => Int, 'required';

=attr containerPort

Number of port to expose on the pod's IP address. This must be a valid port number, 0 < x < 65536.

=cut

k8s hostIP => Str;

=attr hostIP

What host IP to bind the external port to.

=cut

k8s hostPort => Int;

=attr hostPort

Number of port to expose on the host. If specified, this must be a valid port number, 0 < x < 65536. If HostNetwork is specified, this must match ContainerPort. Most containers do not need this.

=cut

k8s name => Str;

=attr name

If specified, this must be an IANA_SVC_NAME and unique within the pod. Each named port in a pod must have a unique name. Name for the port that can be referred to by services.

=cut

k8s protocol => Str;

=attr protocol

Protocol for port. Must be UDP, TCP, or SCTP. Defaults to "TCP".

=cut

1;
