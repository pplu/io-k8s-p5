package IO::K8s::AgentSandbox::V1beta1::SandboxWarmPoolUpdateStrategy;
# ABSTRACT: SandboxWarmPoolUpdateStrategy
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s type => Str, { enum => [qw(Recreate OnReplenish)], default => 'OnReplenish' };

=attr type

No description in the upstream schema.

=cut

1;
