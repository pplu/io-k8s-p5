package IO::K8s::Traefik::V1alpha1::TCPIPAllowList;
# ABSTRACT: IPAllowList defines the IPAllowList middleware configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s sourceRange => [Str];

=attr sourceRange

SourceRange defines the allowed IPs (or ranges of allowed IPs by using CIDR notation).

=cut

1;
