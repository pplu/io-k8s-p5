package IO::K8s::Api::Core::V1::PodTemplate;
# ABSTRACT: PodTemplate describes a template for creating copies of a predefined pod.

use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=head1 DESCRIPTION

PodTemplate describes a template for creating copies of a predefined pod.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s template => 'Core::V1::PodTemplateSpec';

=attr template

Template defines the pods that will be created from this pod template. https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

1;
