package IO::K8s::Cilium::V2::CiliumLocalRedirectPolicySpec;
# ABSTRACT: Spec is the desired behavior of the local redirect policy.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s description             => Str;
k8s redirectBackend         => '+IO::K8s::Cilium::V2::RedirectBackend', { required => 'schema' };
k8s redirectFrontend        => '+IO::K8s::Cilium::V2::RedirectFrontend', { required => 'schema' };
k8s skipRedirectFromBackend => Bool, { default => 0 };

=attr description

Description can be used by the creator of the policy to describe the
purpose of this policy.

=cut

=attr redirectBackend

RedirectBackend specifies backend configuration to redirect traffic to.
It can not be empty.

=cut

=attr redirectFrontend

RedirectFrontend specifies frontend configuration to redirect traffic from.
It can not be empty.

=cut

=attr skipRedirectFromBackend

SkipRedirectFromBackend indicates whether traffic matching RedirectFrontend
from RedirectBackend should skip redirection, and hence the traffic will
be forwarded as-is.

The default is false which means traffic matching RedirectFrontend will
get redirected from all pods, including the RedirectBackend(s).

Example: If RedirectFrontend is configured to "169.254.169.254:80" as the traffic
that needs to be redirected to backends selected by RedirectBackend, if
SkipRedirectFromBackend is set to true, traffic going to "169.254.169.254:80"
from such backends will not be redirected back to the backends. Instead,
the matched traffic from the backends will be forwarded to the original
destination "169.254.169.254:80".

=cut

1;
