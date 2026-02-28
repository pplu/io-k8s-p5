package IO::K8s::Api::Core::V1::EndpointAddress;
# ABSTRACT: EndpointAddress is a tuple that describes single IP address.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s hostname => Str;

=attr hostname

The Hostname of this endpoint

=cut

k8s ip => Str, 'required';

=attr ip

The IP of this endpoint. May not be loopback (127.0.0.0/8 or ::1), link-local (169.254.0.0/16 or fe80::/10), or link-local multicast (224.0.0.0/24 or ff02::/16).

=cut

k8s nodeName => Str;

=attr nodeName

Optional: Node hosting this endpoint. This can be used to determine endpoints local to a node.

=cut

k8s targetRef => 'Core::V1::ObjectReference';

=attr targetRef

Reference to object providing the endpoint.

=cut

1;
