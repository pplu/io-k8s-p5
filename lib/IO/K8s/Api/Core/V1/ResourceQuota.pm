package IO::K8s::Api::Core::V1::ResourceQuota;
# ABSTRACT: ResourceQuota sets aggregate quota restrictions enforced per namespace
our $VERSION = '1.002';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

ResourceQuota sets aggregate quota restrictions enforced per namespace

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'Core::V1::ResourceQuotaSpec';

=attr spec

Spec defines the desired quota. https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

k8s status => 'Core::V1::ResourceQuotaStatus';

=attr status

Status defines the actual enforced quota and its current usage. https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#resourcequota-v1-core>

=cut
1;
