package IO::K8s::Traefik::V1alpha1::RateLimit;
# ABSTRACT: RateLimit holds the rate limit configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s average         => Int, { minimum => 0 };
k8s burst           => Int, { minimum => 0 };
k8s period          => IntOrStr;
k8s redis           => '+IO::K8s::Traefik::V1alpha1::Redis';
k8s sourceCriterion => '+IO::K8s::Traefik::V1alpha1::SourceCriterion';

=attr average

Average is the maximum rate, by default in requests/s, allowed for the given source.
It defaults to 0, which means no rate limiting.
The rate is actually defined by dividing Average by Period. So for a rate below 1req/s,
one needs to define a Period larger than a second.

=cut

=attr burst

Burst is the maximum number of requests allowed to arrive in the same arbitrarily small period of time.
It defaults to 1.

=cut

=attr period

Period, in combination with Average, defines the actual maximum rate, such as:
r = Average / Period. It defaults to a second.

=cut

=attr redis

Redis hold the configs of Redis as bucket in rate limiter.

=cut

=attr sourceCriterion

SourceCriterion defines what criterion is used to group requests as originating from a common source.
If several strategies are defined at the same time, an error will be raised.
If none are set, the default is to use the request's remote address field (as an ipStrategy).

=cut

1;
