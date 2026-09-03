package IO::K8s::Traefik::V1alpha1::StripPrefixRegex;
# ABSTRACT: StripPrefixRegex holds the strip prefix regex middleware configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s regex => [Str];

=attr regex

Regex defines the regular expression to match the path prefix from the request URL.

=cut

1;
