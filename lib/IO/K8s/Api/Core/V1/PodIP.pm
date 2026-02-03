package IO::K8s::Api::Core::V1::PodIP;
# ABSTRACT: PodIP represents a single IP address allocated to the pod.

use IO::K8s::Resource;

k8s ip => Str, 'required';

=attr ip

IP is the IP address assigned to the pod

=cut

1;
