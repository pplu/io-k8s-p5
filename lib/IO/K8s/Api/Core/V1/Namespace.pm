package IO::K8s::Api::Core::V1::Namespace;
# ABSTRACT: Namespace provides a scope for Names. Use of multiple namespaces is optional.

use IO::K8s::APIObject;

=head1 DESCRIPTION

Namespace provides a scope for Names. Use of multiple namespaces is optional.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'Core::V1::NamespaceSpec';

=attr spec

Spec defines the behavior of the Namespace. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

k8s status => 'Core::V1::NamespaceStatus';

=attr status

Status describes the current status of a Namespace. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

1;
