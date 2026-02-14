package IO::K8s::Api::Batch::V1::JobCondition;
# ABSTRACT: JobCondition describes current state of a job.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s lastProbeTime => Str;

=attr lastProbeTime

Last time the condition was checked.

=cut

k8s lastTransitionTime => Str;

=attr lastTransitionTime

Last time the condition transit from one status to another.

=cut

k8s message => Str;

=attr message

Human readable message indicating details about last transition.

=cut

k8s reason => Str;

=attr reason

(brief) reason for the condition's last transition.

=cut

k8s status => Str, 'required';

=attr status

Status of the condition, one of True, False, Unknown.

=cut

k8s type => Str, 'required';

=attr type

Type of job condition, Complete or Failed.

=cut

1;
