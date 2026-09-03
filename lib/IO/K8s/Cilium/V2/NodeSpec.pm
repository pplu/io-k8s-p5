package IO::K8s::Cilium::V2::NodeSpec;
# ABSTRACT: Spec defines the desired specification/configuration of the node.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s addresses       => ['+IO::K8s::Cilium::V2::NodeAddress'];
k8s 'alibaba-cloud' => '+IO::K8s::Cilium::V2::AlibabaCloudSpec';
k8s azure           => '+IO::K8s::Cilium::V2::AzureSpec';
k8s bootid          => Str;
k8s encryption      => '+IO::K8s::Cilium::V2::EncryptionSpec';
k8s eni             => '+IO::K8s::Cilium::V2::ENISpec';
k8s health          => '+IO::K8s::Cilium::V2::HealthAddressingSpec';
k8s ingress         => '+IO::K8s::Cilium::V2::AddressPair';
k8s 'instance-id'   => Str;
k8s ipam            => '+IO::K8s::Cilium::V2::IPAMSpec';

=attr addresses

Addresses is the list of all node addresses.

=cut

=attr alibaba-cloud

AlibabaCloud is the AlibabaCloud IPAM specific configuration.

=cut

=attr azure

Azure is the Azure IPAM specific configuration.

=cut

=attr bootid

BootID is a unique node identifier generated on boot

=cut

=attr encryption

Encryption is the encryption configuration of the node.

=cut

=attr eni

ENI is the AWS ENI specific configuration.

=cut

=attr health

HealthAddressing is the addressing information for health connectivity
checking.

=cut

=attr ingress

IngressAddressing is the addressing information for Ingress listener.

=cut

=attr instance-id

InstanceID is the identifier of the node. This is different from the
node name which is typically the FQDN of the node. The InstanceID
typically refers to the identifier used by the cloud provider or
some other means of identification.

=cut

=attr ipam

IPAM is the address management specification. This section can be
populated by a user or it can be automatically populated by an IPAM
operator.

=cut

1;
