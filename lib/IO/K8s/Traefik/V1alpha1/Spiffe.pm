package IO::K8s::Traefik::V1alpha1::Spiffe;
# ABSTRACT: Spiffe defines the SPIFFE configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s ids         => [Str];
k8s trustDomain => Str;

=attr ids

IDs defines the allowed SPIFFE IDs (takes precedence over the SPIFFE TrustDomain).

=cut

=attr trustDomain

TrustDomain defines the allowed SPIFFE trust domain.

=cut

1;
