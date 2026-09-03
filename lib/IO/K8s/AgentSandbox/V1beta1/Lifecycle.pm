package IO::K8s::AgentSandbox::V1beta1::Lifecycle;
# ABSTRACT: Lifecycle
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s shutdownPolicy          => Str, { enum => [qw(Delete DeleteForeground Retain)], default => 'Retain' };
k8s shutdownTime            => Time;
k8s ttlSecondsAfterFinished => Int, { minimum => 0 };

=attr shutdownPolicy

No description in the upstream schema.

=cut

=attr shutdownTime

No description in the upstream schema.

=cut

=attr ttlSecondsAfterFinished

No description in the upstream schema.

=cut

1;
