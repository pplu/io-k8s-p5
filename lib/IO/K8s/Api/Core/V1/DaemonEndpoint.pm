package IO::K8s::Api::Core::V1::DaemonEndpoint;
# ABSTRACT: DaemonEndpoint contains information about a single Daemon endpoint.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s Port => Int, 'required';

=attr Port

Port number of the given endpoint.

=cut

1;
