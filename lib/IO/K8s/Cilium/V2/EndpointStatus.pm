package IO::K8s::Cilium::V2::EndpointStatus;
# ABSTRACT: EndpointStatus is the status of a Cilium endpoint.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s controllers            => ['+IO::K8s::Cilium::V2::ControllerStatus'];
k8s encryption             => '+IO::K8s::Cilium::V2::EncryptionSpec';
k8s 'external-identifiers' => '+IO::K8s::Cilium::V2::EndpointIdentifiers';
k8s health                 => '+IO::K8s::Cilium::V2::EndpointHealth';
k8s id                     => Int;
k8s identity               => '+IO::K8s::Cilium::V2::EndpointIdentity';
k8s log                    => ['+IO::K8s::Cilium::V2::EndpointStatusChange'];
k8s 'named-ports'          => ['+IO::K8s::Cilium::V2::Port'];
k8s networking             => '+IO::K8s::Cilium::V2::EndpointNetworking';
k8s policy                 => '+IO::K8s::Cilium::V2::EndpointPolicy';
k8s 'service-account'      => Str;
k8s state                  => Str, { enum => [qw(creating waiting-for-identity not-ready waiting-to-regenerate regenerating restoring ready disconnecting disconnected invalid)] };

=attr controllers

Controllers is the list of failing controllers for this endpoint.

=cut

=attr encryption

Encryption is the encryption configuration of the node

=cut

=attr external-identifiers

ExternalIdentifiers is a set of identifiers to identify the endpoint
apart from the pod name. This includes container runtime IDs.

=cut

=attr health

Health is the overall endpoint & subcomponent health.

=cut

=attr id

ID is the cilium-agent-local ID of the endpoint.

=cut

=attr identity

Identity is the security identity associated with the endpoint

=cut

=attr log

Log is the list of the last few warning and error log entries

=cut

=attr named-ports

NamedPorts List of named Layer 4 port and protocol pairs which will be used in Network
Policy specs.

swagger:model NamedPorts

=cut

=attr networking

Networking is the networking properties of the endpoint.

=cut

=attr policy

EndpointPolicy represents the endpoint's policy by listing all allowed
ingress and egress identities in combination with L4 port and protocol.

=cut

=attr service-account

ServiceAccount is the service account associated with the endpoint

=cut

=attr state

State is the state of the endpoint.

=cut

1;
