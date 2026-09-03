package IO::K8s::Cilium::V2::NodeStatus;
# ABSTRACT: Status defines the realized specification/configuration and status of the node.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s 'alibaba-cloud' => '+IO::K8s::Cilium::V2::AlibabaCloudENIStatus';
k8s azure           => '+IO::K8s::Cilium::V2::AzureStatus';
k8s eni             => '+IO::K8s::Cilium::V2::ENIStatus';
k8s ipam            => '+IO::K8s::Cilium::V2::IPAMStatus';

=attr alibaba-cloud

AlibabaCloud is the AlibabaCloud specific status of the node.

=cut

=attr azure

Azure is the Azure specific status of the node.

=cut

=attr eni

ENI is the AWS ENI specific status of the node.

=cut

=attr ipam

IPAM is the IPAM status of the node.

=cut

1;
