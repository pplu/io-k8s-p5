package IO::K8s::Traefik::V1alpha1::Cookie;
# ABSTRACT: Cookie defines the sticky cookie configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s domain   => Str;
k8s httpOnly => Bool;
k8s maxAge   => Int;
k8s name     => Str;
k8s path     => Str;
k8s sameSite => Str, { enum => [qw(none lax strict None Lax Strict)] };
k8s secure   => Bool;

=attr domain

Domain defines the host to which the cookie will be sent.
More info: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie#domaindomain-value

=cut

=attr httpOnly

HTTPOnly defines whether the cookie can be accessed by client-side APIs, such as JavaScript.

=cut

=attr maxAge

MaxAge defines the number of seconds until the cookie expires.
When set to a negative number, the cookie expires immediately.
When set to zero, the cookie never expires.

=cut

=attr name

Name defines the Cookie name.

=cut

=attr path

Path defines the path that must exist in the requested URL for the browser to send the Cookie header.
When not provided the cookie will be sent on every request to the domain.
More info: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie#pathpath-value

=cut

=attr sameSite

SameSite defines the same site policy.
More info: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie/SameSite

=cut

=attr secure

Secure defines whether the cookie can only be transmitted over an encrypted connection (i.e. HTTPS).

=cut

1;
