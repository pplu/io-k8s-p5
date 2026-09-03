package IO::K8s::AgentSandbox::V1beta1::SandboxClaimStatusSandbox;
# ABSTRACT: SandboxClaimStatusSandbox
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name        => Str;
k8s podIPs      => [Str];
k8s serviceFQDN => Str;

=attr name

No description in the upstream schema.

=cut

=attr podIPs

No description in the upstream schema.

=cut

=attr serviceFQDN

No description in the upstream schema.

=cut

1;
