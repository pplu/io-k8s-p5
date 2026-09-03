package IO::K8s::Cilium::V2alpha1::CoreCiliumEndpoint;
# ABSTRACT: CoreCiliumEndpoint is slim version of status of CiliumEndpoint.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s encryption        => '+IO::K8s::Cilium::V2alpha1::EncryptionSpec';
k8s id                => Int;
k8s name              => Str;
k8s 'named-ports'     => ['+IO::K8s::Cilium::V2alpha1::Port'];
k8s networking        => '+IO::K8s::Cilium::V2alpha1::EndpointNetworking';
k8s 'pod-uid'         => Str;
k8s 'service-account' => Str;

=attr encryption

EncryptionSpec defines the encryption relevant configuration of a node.

=cut

=attr id

IdentityID is the numeric identity of the endpoint

=cut

=attr name

Name indicate as CiliumEndpoint name.

=cut

=attr named-ports

NamedPorts List of named Layer 4 port and protocol pairs which will be used in Network
Policy specs.

swagger:model NamedPorts

=cut

=attr networking

EndpointNetworking is the addressing information of an endpoint.

=cut

=attr pod-uid

PodUID is the UID of the Pod that owns this endpoint.

=cut

=attr service-account

ServiceAccount is the service account of the endpoint.

=cut

1;
