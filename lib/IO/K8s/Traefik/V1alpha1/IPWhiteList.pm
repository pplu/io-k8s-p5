package IO::K8s::Traefik::V1alpha1::IPWhiteList;
# ABSTRACT: Deprecated: please use IPAllowList instead.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s ipStrategy  => '+IO::K8s::Traefik::V1alpha1::IPStrategy';
k8s sourceRange => [Str];

=attr ipStrategy

IPStrategy holds the IP strategy configuration used by Traefik to determine the client IP.
More info: https://doc.traefik.io/traefik/v3.7/middlewares/http/ipallowlist/#ipstrategy

=cut

=attr sourceRange

SourceRange defines the set of allowed IPs (or ranges of allowed IPs by using CIDR notation). Required.

=cut

1;
