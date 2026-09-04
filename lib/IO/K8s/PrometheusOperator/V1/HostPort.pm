package IO::K8s::PrometheusOperator::V1::HostPort;
# ABSTRACT: HostPort represents a "host:port" network address.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s host => Str, { required => 'schema' };
k8s port => Str, { required => 'schema' };

=attr host

host defines the host's address, it can be a DNS name or a literal IP address.

=cut

=attr port

port defines the host's port, it can be a literal port number or a port name.

=cut

1;
