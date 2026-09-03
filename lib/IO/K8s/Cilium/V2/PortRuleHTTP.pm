package IO::K8s::Cilium::V2::PortRuleHTTP;
# ABSTRACT: PortRuleHTTP is a list of HTTP protocol constraints.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s headerMatches => ['+IO::K8s::Cilium::V2::HeaderMatch'];
k8s headers       => [Str];
k8s host          => Str;
k8s method        => Str;
k8s path          => Str;

=attr headerMatches

HeaderMatches is a list of HTTP headers which must be
present and match against the given values. Mismatch field can be used
to specify what to do when there is no match.

=cut

=attr headers

Headers is a list of HTTP headers which must be present in the
request. If omitted or empty, requests are allowed regardless of
headers present.

=cut

=attr host

Host is an extended POSIX regex matched against the host header of a
request. Examples:

- foo.bar.com will match the host fooXbar.com or foo-bar.com
- foo\.bar\.com will only match the host foo.bar.com

If omitted or empty, the value of the host header is ignored.

=cut

=attr method

Method is an extended POSIX regex matched against the method of a
request, e.g. "GET", "POST", "PUT", "PATCH", "DELETE", ...

If omitted or empty, all methods are allowed.

=cut

=attr path

Path is an extended POSIX regex matched against the path of a
request. Currently it can contain characters disallowed from the
conventional "path" part of a URL as defined by RFC 3986.

If omitted or empty, all paths are all allowed.

=cut

1;
