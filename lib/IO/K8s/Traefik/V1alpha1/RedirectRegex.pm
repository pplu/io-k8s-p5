package IO::K8s::Traefik::V1alpha1::RedirectRegex;
# ABSTRACT: RedirectRegex holds the redirect regex middleware configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s permanent   => Bool;
k8s regex       => Str;
k8s replacement => Str;

=attr permanent

Permanent defines whether the redirection is permanent (308).

=cut

=attr regex

Regex defines the regex used to match and capture elements from the request URL.

=cut

=attr replacement

Replacement defines how to modify the URL to have the new target URL.

=cut

1;
