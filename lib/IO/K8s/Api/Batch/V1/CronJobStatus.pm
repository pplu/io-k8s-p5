package IO::K8s::Api::Batch::V1::CronJobStatus;
# ABSTRACT: CronJobStatus represents the current state of a cron job.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s active => ['Core::V1::ObjectReference'];

=attr active

A list of pointers to currently running jobs.

=cut

k8s lastScheduleTime => Time;

=attr lastScheduleTime

Information when was the last time the job was successfully scheduled.

=cut

k8s lastSuccessfulTime => Time;

=attr lastSuccessfulTime

Information when was the last time the job successfully completed.

=cut

1;
