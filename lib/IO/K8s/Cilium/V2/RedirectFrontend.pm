package IO::K8s::Cilium::V2::RedirectFrontend;
# ABSTRACT: RedirectFrontend specifies frontend configuration to redirect traffic from.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s addressMatcher => '+IO::K8s::Cilium::V2::Frontend';
k8s serviceMatcher => '+IO::K8s::Cilium::V2::ServiceInfo';

=attr addressMatcher

AddressMatcher is a tuple {IP, port, protocol} that matches traffic to be
redirected.

=cut

=attr serviceMatcher

ServiceMatcher specifies Kubernetes service and port that matches
traffic to be redirected.

=cut

1;
