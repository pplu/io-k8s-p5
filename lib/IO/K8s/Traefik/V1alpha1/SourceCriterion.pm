package IO::K8s::Traefik::V1alpha1::SourceCriterion;
# ABSTRACT: SourceCriterion defines what criterion is used to group requests as originating from a common source.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s ipStrategy        => '+IO::K8s::Traefik::V1alpha1::IPStrategy';
k8s requestHeaderName => Str;
k8s requestHost       => Bool;

=attr ipStrategy

IPStrategy holds the IP strategy configuration used by Traefik to determine the client IP.
More info: https://doc.traefik.io/traefik/v3.7/middlewares/http/ipallowlist/#ipstrategy

=cut

=attr requestHeaderName

RequestHeaderName defines the name of the header used to group incoming requests.

=cut

=attr requestHost

RequestHost defines whether to consider the request Host as the source.

=cut

1;
