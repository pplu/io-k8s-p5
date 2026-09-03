package IO::K8s::GatewayAPI::V1beta1::GatewayStatusAddress;
# ABSTRACT: GatewayStatusAddress describes a network address that is bound to a Gateway.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s type  => Str, { pattern => qr/^Hostname|IPAddress|NamedAddress|[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\/[A-Za-z0-9\/\-._~%!\$&'()*+,;=:]+$/, default => 'IPAddress' };
k8s value => Str, { required => 'schema' };

=attr type

Type of the address.

=cut

=attr value

Value of the address. The validity of the values will depend
on the type and support by the controller.

Examples: `1.2.3.4`, `128::1`, `my-ip-address`.

=cut

1;
