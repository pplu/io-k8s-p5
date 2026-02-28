package IO::K8s::Api::Batch::V1::CronJob;
# ABSTRACT: CronJob represents the configuration of a single cron job.
our $VERSION = '1.006';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

CronJob represents the configuration of a single cron job.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Batch::V1::CronJobSpec';

=attr spec

Specification of the desired behavior of a cron job, including the schedule. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status


=cut

k8s status => 'Batch::V1::CronJobStatus';

=attr status

Current status of a cron job. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#cronjob-v1-batch>


=cut
1;
