package IO::K8s::Cilium::V2::AzureStatus;
# ABSTRACT: Azure is the Azure specific status of the node.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s interfaces => ['+IO::K8s::Cilium::V2::AzureInterface'];

=attr interfaces

Interfaces is the list of interfaces on the node

=cut

1;
