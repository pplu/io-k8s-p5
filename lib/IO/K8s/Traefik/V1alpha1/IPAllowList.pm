package IO::K8s::Traefik::V1alpha1::IPAllowList;
# ABSTRACT: IPAllowList holds the IP allowlist middleware configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s ipStrategy       => '+IO::K8s::Traefik::V1alpha1::IPStrategy';
k8s rejectStatusCode => Int;
k8s sourceRange      => [Str];

=attr ipStrategy

IPStrategy holds the IP strategy configuration used by Traefik to determine the client IP.
More info: https://doc.traefik.io/traefik/v3.7/middlewares/http/ipallowlist/#ipstrategy

=cut

=attr rejectStatusCode

RejectStatusCode defines the HTTP status code used for refused requests.
If not set, the default is 403 (Forbidden).

=cut

=attr sourceRange

SourceRange defines the set of allowed IPs (or ranges of allowed IPs by using CIDR notation).

=cut

1;
