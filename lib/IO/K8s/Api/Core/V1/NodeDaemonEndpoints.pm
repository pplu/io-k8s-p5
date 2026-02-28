package IO::K8s::Api::Core::V1::NodeDaemonEndpoints;
# ABSTRACT: NodeDaemonEndpoints lists ports opened by daemons running on the Node.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s kubeletEndpoint => 'Core::V1::DaemonEndpoint';

=attr kubeletEndpoint

Endpoint on which Kubelet is listening.

=cut

1;
