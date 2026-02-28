package IO::K8s::Api::Core::V1::Pod;
# ABSTRACT: Pod is a collection of containers that can run on a host. This resource is created by clients and scheduled onto hosts.
our $VERSION = '1.005';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

Pod is a collection of containers that can run on a host. This resource is created by clients and scheduled onto hosts.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Core::V1::PodSpec';

=attr spec

Specification of the desired behavior of the pod. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status


=cut

k8s status => 'Core::V1::PodStatus';

=attr status

Most recently observed status of the pod. This data may not be up to date. Populated by the system. Read-only. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status


=cut

=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#pod-v1-core>


=cut

1;
