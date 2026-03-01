package IO::K8s::Api::Core::V1::PodTemplateSpec;
# ABSTRACT: PodTemplateSpec describes the data a pod should have when created from a template
our $VERSION = '1.007';
use IO::K8s::APIObject;

=description

PodTemplateSpec describes the data a pod should have when created from a template

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'Core::V1::PodSpec';

=attr spec

Specification of the desired behavior of the pod. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

1;
