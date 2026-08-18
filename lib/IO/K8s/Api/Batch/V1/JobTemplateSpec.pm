package IO::K8s::Api::Batch::V1::JobTemplateSpec;
# ABSTRACT: JobTemplateSpec describes the data a Job should have when created from a template
our $VERSION = '1.108';
use IO::K8s::Resource;

=description

JobTemplateSpec describes the data a Job should have when created from a template

=cut

k8s metadata => 'Meta::V1::ObjectMeta';

=attr metadata

Standard object's metadata. See L<IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta>.

=cut

k8s spec => 'Batch::V1::JobSpec';

=attr spec

Specification of the desired behavior of the job. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

1;
