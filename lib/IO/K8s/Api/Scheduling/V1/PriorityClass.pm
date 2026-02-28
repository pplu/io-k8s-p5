package IO::K8s::Api::Scheduling::V1::PriorityClass;
# ABSTRACT: PriorityClass defines mapping from a priority class name to the priority integer value. The value can be any valid integer.
our $VERSION = '1.004';
use IO::K8s::APIObject;

=description

PriorityClass defines mapping from a priority class name to the priority integer value. The value can be any valid integer.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s description => Str;

=attr description

description is an arbitrary string that usually provides guidelines on when this priority class should be used.


=cut

k8s globalDefault => Bool;

=attr globalDefault

globalDefault specifies whether this PriorityClass should be considered as the default priority for pods that do not have any priority class. Only one PriorityClass can be marked as `globalDefault`. However, if more than one PriorityClasses exists with their `globalDefault` field set to true, the smallest value of such global default PriorityClasses will be used as the default priority.


=cut

k8s preemptionPolicy => Str;

=attr preemptionPolicy

preemptionPolicy is the Policy for preempting pods with lower priority. One of Never, PreemptLowerPriority. Defaults to PreemptLowerPriority if unset.


=cut

k8s value => Int, 'required';

=attr value

value represents the integer value of this priority class. This is the actual priority that pods receive when they have the name of this class in their pod spec.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#priorityclass-v1-scheduling.k8s.io>


=cut
1;
