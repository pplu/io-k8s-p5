package IO::K8s::Api::Core::V1::Node;
# ABSTRACT: Node is a worker node in Kubernetes. Each node will have a unique identifier in the cache (i.e. in etcd).
our $VERSION = '1.004';
use IO::K8s::APIObject;

=description

Node is a worker node in Kubernetes. Each node will have a unique identifier in the cache (i.e. in etcd).

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Core::V1::NodeSpec';

=attr spec

Spec defines the behavior of a node. https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status


=cut

k8s status => 'Core::V1::NodeStatus';

=attr status

Most recently observed status of the node. Populated by the system. Read-only. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#node-v1-core>


=cut
1;
