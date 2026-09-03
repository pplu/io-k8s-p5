package IO::K8s::AgentSandbox::V1beta1::PodReadinessGate;
# ABSTRACT: PodReadinessGate
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conditionType => Str, { required => 'schema' };

=attr conditionType

No description in the upstream schema.

=cut

1;
