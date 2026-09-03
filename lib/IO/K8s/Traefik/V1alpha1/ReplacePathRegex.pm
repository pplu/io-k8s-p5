package IO::K8s::Traefik::V1alpha1::ReplacePathRegex;
# ABSTRACT: ReplacePathRegex holds the replace path regex middleware configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s regex       => Str;
k8s replacement => Str;

=attr regex

Regex defines the regular expression used to match and capture the path from the request URL.

=cut

=attr replacement

Replacement defines the replacement path format, which can include captured variables.

=cut

1;
