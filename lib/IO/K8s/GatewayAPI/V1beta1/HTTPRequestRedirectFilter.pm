package IO::K8s::GatewayAPI::V1beta1::HTTPRequestRedirectFilter;
# ABSTRACT: RequestRedirect defines a schema for a filter that responds to the request with an HTTP redirection.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s hostname   => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };
k8s path       => '+IO::K8s::GatewayAPI::V1beta1::HTTPPathModifier';
k8s port       => Int, { minimum => 1, maximum => 65535 };
k8s scheme     => Str, { enum => [qw(http https)] };
k8s statusCode => Int, { enum => [qw(301 302 303 307 308)], default => 302 };

=attr hostname

Hostname is the hostname to be used in the value of the `Location`
header in the response.
When empty, the hostname in the `Host` header of the request is used.

Support: Core

=cut

=attr path

Path defines parameters used to modify the path of the incoming request.
The modified path is then used to construct the `Location` header. When
empty, the request path is used as-is.

Support: Extended

=cut

=attr port

Port is the port to be used in the value of the `Location`
header in the response.

If no port is specified, the redirect port MUST be derived using the
following rules:

* If redirect scheme is not-empty, the redirect port MUST be the well-known
  port associated with the redirect scheme. Specifically "http" to port 80
  and "https" to port 443. If the redirect scheme does not have a
  well-known port, the listener port of the Gateway SHOULD be used.
* If redirect scheme is empty, the redirect port MUST be the Gateway
  Listener port.

Implementations SHOULD NOT add the port number in the 'Location'
header in the following cases:

* A Location header that will use HTTP (whether that is determined via
  the Listener protocol or the Scheme field) _and_ use port 80.
* A Location header that will use HTTPS (whether that is determined via
  the Listener protocol or the Scheme field) _and_ use port 443.

Support: Extended

=cut

=attr scheme

Scheme is the scheme to be used in the value of the `Location` header in
the response. When empty, the scheme of the request is used.

Scheme redirects can affect the port of the redirect, for more information,
refer to the documentation for the port field of this filter.

Note that values may be added to this enum, implementations
must ensure that unknown values will not cause a crash.

Unknown values here must result in the implementation setting the
Accepted Condition for the Route to `status: False`, with a
Reason of `UnsupportedValue`.

Support: Extended

=cut

=attr statusCode

StatusCode is the HTTP status code to be used in response.

Note that values may be added to this enum, implementations
must ensure that unknown values will not cause a crash.

Unknown values here must result in the implementation setting the
Accepted Condition for the Route to `status: False`, with a
Reason of `UnsupportedValue`.

Support: Core

=cut

1;
