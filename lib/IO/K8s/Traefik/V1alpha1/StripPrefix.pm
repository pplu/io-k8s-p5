package IO::K8s::Traefik::V1alpha1::StripPrefix;
# ABSTRACT: StripPrefix holds the strip prefix middleware configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s forceSlash => Bool;
k8s prefixes   => [Str];

=attr forceSlash

Deprecated: ForceSlash option is deprecated, please remove any usage of this option.
ForceSlash ensures that the resulting stripped path is not the empty string, by replacing it with / when necessary.
Default: true.

=cut

=attr prefixes

Prefixes defines the prefixes to strip from the request URL.

=cut

1;
