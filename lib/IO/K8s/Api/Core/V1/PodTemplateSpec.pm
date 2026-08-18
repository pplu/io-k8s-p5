package IO::K8s::Api::Core::V1::PodTemplateSpec;
# ABSTRACT: PodTemplateSpec describes the data a pod should have when created from a template
our $VERSION = '1.108';
use IO::K8s::Resource;

=description

PodTemplateSpec describes the data a pod should have when created from a template

=cut

k8s metadata => 'Meta::V1::ObjectMeta';

=attr metadata

Standard object's metadata. See L<IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta>.

=cut

k8s spec => 'Core::V1::PodSpec';

=attr spec

Specification of the desired behavior of the pod. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

1;
