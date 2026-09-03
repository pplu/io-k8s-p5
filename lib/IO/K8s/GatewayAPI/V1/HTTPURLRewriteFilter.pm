package IO::K8s::GatewayAPI::V1::HTTPURLRewriteFilter;
# ABSTRACT: URLRewrite defines a schema for a filter that modifies a request during forwarding.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s hostname => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };
k8s path     => '+IO::K8s::GatewayAPI::V1::HTTPPathModifier';

=attr hostname

Hostname is the value to be used to replace the Host header value during
forwarding.

Support: Extended

=cut

=attr path

Path defines a path rewrite.

Support: Extended

=cut

1;
