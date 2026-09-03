package IO::K8s::Cilium::V2alpha1::CiliumGatewayClassConfigStatus;
# ABSTRACT: Status is the status of the policy.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conditions => ['Meta::V1::Condition'];

=attr conditions

Current service state

=cut

1;
