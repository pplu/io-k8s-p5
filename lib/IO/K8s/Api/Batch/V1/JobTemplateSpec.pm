package IO::K8s::Api::Batch::V1::JobTemplateSpec;
# ABSTRACT: JobTemplateSpec describes the data a Job should have when created from a template

use IO::K8s::APIObject;

=head1 DESCRIPTION

JobTemplateSpec describes the data a Job should have when created from a template

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'Batch::V1::JobSpec';

=attr spec

Specification of the desired behavior of the job. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

1;
