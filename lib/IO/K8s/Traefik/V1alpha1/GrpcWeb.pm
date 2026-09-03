package IO::K8s::Traefik::V1alpha1::GrpcWeb;
# ABSTRACT: GrpcWeb holds the gRPC web middleware configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s allowOrigins => [Str];

=attr allowOrigins

AllowOrigins is a list of allowable origins.
Can also be a wildcard origin "*".

=cut

1;
