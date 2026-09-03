package IO::K8s::Cilium::V2::EndpointIdentifiers;
# ABSTRACT: ExternalIdentifiers is a set of identifiers to identify the endpoint apart from the pod name.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s 'cni-attachment-id'  => Str;
k8s 'container-id'       => Str;
k8s 'container-name'     => Str;
k8s 'docker-endpoint-id' => Str;
k8s 'docker-network-id'  => Str;
k8s 'k8s-namespace'      => Str;
k8s 'k8s-pod-name'       => Str;
k8s 'pod-name'           => Str;

=attr cni-attachment-id

ID assigned to this attachment by container runtime

=cut

=attr container-id

ID assigned by container runtime (deprecated, may not be unique)

=cut

=attr container-name

Name assigned to container (deprecated, may not be unique)

=cut

=attr docker-endpoint-id

Docker endpoint ID

=cut

=attr docker-network-id

Docker network ID

=cut

=attr k8s-namespace

K8s namespace for this endpoint (deprecated, may not be unique)

=cut

=attr k8s-pod-name

K8s pod name for this endpoint (deprecated, may not be unique)

=cut

=attr pod-name

K8s pod for this endpoint (deprecated, may not be unique)

=cut

1;
