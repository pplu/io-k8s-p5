package IO::K8s::Cilium::V2::ENIStatus;
# ABSTRACT: ENI is the AWS ENI specific status of the node.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s enis => { '+IO::K8s::Cilium::V2::ENI' => 1 };

=attr enis

ENIs is the list of ENIs on the node

=cut

1;
