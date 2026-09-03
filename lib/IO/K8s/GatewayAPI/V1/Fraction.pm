package IO::K8s::GatewayAPI::V1::Fraction;
# ABSTRACT: Fraction represents the fraction of requests that should be mirrored to BackendRef.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s denominator => Int, { minimum => 1, default => 100 };
k8s numerator   => Int, { required => 'schema', minimum => 0 };

=attr denominator

No description in the upstream schema.

=cut

=attr numerator

No description in the upstream schema.

=cut

1;
