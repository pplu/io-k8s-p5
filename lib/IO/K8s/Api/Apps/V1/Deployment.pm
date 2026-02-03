package IO::K8s::Api::Apps::V1::Deployment;
# ABSTRACT: Deployment enables declarative updates for Pods and ReplicaSets.

use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=head1 DESCRIPTION

Deployment enables declarative updates for Pods and ReplicaSets.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'Apps::V1::DeploymentSpec';

=attr spec

Specification of the desired behavior of the Deployment.

=cut

k8s status => 'Apps::V1::DeploymentStatus';

=attr status

Most recently observed status of the Deployment.

=cut

1;
