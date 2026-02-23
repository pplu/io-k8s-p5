package IO::K8s::Api::Core::V1::HostIP;
# ABSTRACT: HostIP represents a single IP address allocated to the host.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s ip => Str, 'required';

=attr ip

IP is the IP address assigned to the host

=cut

1;
