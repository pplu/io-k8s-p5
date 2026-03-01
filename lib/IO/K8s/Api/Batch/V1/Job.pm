package IO::K8s::Api::Batch::V1::Job;
# ABSTRACT: Job represents the configuration of a single job.
our $VERSION = '1.007';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

Job represents the configuration of a single job.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Batch::V1::JobSpec';

=attr spec

Specification of the desired behavior of a job. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status


=cut

k8s status => 'Batch::V1::JobStatus';

=attr status

Current status of a job. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#job-v1-batch>


=cut
1;
