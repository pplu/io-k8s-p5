package IO::K8s::Traefik::V1alpha1::RedirectScheme;
# ABSTRACT: RedirectScheme holds the redirect scheme middleware configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s permanent => Bool;
k8s port      => Str;
k8s scheme    => Str;

=attr permanent

Permanent defines whether the redirection is permanent.
For HTTP GET requests a 301 is returned, otherwise a 308 is returned.

=cut

=attr port

Port defines the port of the new URL.

=cut

=attr scheme

Scheme defines the scheme of the new URL.

=cut

1;
