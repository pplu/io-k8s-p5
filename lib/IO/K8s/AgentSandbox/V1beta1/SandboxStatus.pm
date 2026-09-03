package IO::K8s::AgentSandbox::V1beta1::SandboxStatus;
# ABSTRACT: SandboxStatus
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conditions  => ['Meta::V1::Condition'];
k8s nodeName    => Str;
k8s podIPs      => [Str];
k8s selector    => Str;
k8s service     => Str;
k8s serviceFQDN => Str;

=attr conditions

No description in the upstream schema.

=cut

=attr nodeName

No description in the upstream schema.

=cut

=attr podIPs

No description in the upstream schema.

=cut

=attr selector

No description in the upstream schema.

=cut

=attr service

No description in the upstream schema.

=cut

=attr serviceFQDN

No description in the upstream schema.

=cut

1;
