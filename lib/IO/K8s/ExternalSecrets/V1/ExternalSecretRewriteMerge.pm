package IO::K8s::ExternalSecrets::V1::ExternalSecretRewriteMerge;
# ABSTRACT: Used to merge key/values in one single Secret The resulting key will contain all values from the specified secrets
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conflictPolicy => Str, { enum => [qw(Ignore Error)], default => 'Error' };
k8s into           => Str, { default => '' };
k8s priority       => [Str];
k8s priorityPolicy => Str, { enum => [qw(IgnoreNotFound Strict)], default => 'Strict' };
k8s strategy       => Str, { enum => [qw(Extract JSON)], default => 'Extract' };

=attr conflictPolicy

Used to define the policy to use in conflict resolution.

=cut

=attr into

Used to define the target key of the merge operation.
Required if strategy is JSON. Ignored otherwise.

=cut

=attr priority

Used to define key priority in conflict resolution.

=cut

=attr priorityPolicy

Used to define the policy when a key in the priority list does not exist in the input.

=cut

=attr strategy

Used to define the strategy to use in the merge operation.

=cut

1;
