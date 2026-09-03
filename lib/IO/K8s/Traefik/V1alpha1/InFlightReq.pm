package IO::K8s::Traefik::V1alpha1::InFlightReq;
# ABSTRACT: InFlightReq holds the in-flight request middleware configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s amount          => Int, { minimum => 0 };
k8s sourceCriterion => '+IO::K8s::Traefik::V1alpha1::SourceCriterion';

=attr amount

Amount defines the maximum amount of allowed simultaneous in-flight request.
The middleware responds with HTTP 429 Too Many Requests if there are already amount requests in progress (based on the same sourceCriterion strategy).

=cut

=attr sourceCriterion

SourceCriterion defines what criterion is used to group requests as originating from a common source.
If several strategies are defined at the same time, an error will be raised.
If none are set, the default is to use the requestHost.
More info: https://doc.traefik.io/traefik/v3.7/middlewares/http/inflightreq/#sourcecriterion

=cut

1;
