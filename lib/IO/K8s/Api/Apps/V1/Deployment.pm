package IO::K8s::Api::Apps::V1::Deployment;
# ABSTRACT: Deployment enables declarative updates for Pods and ReplicaSets.
our $VERSION = '1.108';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

Deployment enables declarative updates for Pods and ReplicaSets.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'Apps::V1::DeploymentSpec', 'required';

=attr spec

Specification of the desired behavior of the Deployment.

=cut

k8s status => 'Apps::V1::DeploymentStatus';

=attr status

Most recently observed status of the Deployment.

=cut

=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.37/#deployment-v1-apps>

=cut

1;
