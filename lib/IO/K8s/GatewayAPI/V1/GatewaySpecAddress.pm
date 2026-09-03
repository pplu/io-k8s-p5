package IO::K8s::GatewayAPI::V1::GatewaySpecAddress;
# ABSTRACT: GatewaySpecAddress describes an address that can be bound to a Gateway.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s type  => Str, { pattern => qr/^Hostname|IPAddress|NamedAddress|[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\/[A-Za-z0-9\/\-._~%!\$&'()*+,;=:]+$/, default => 'IPAddress' };
k8s value => Str;

=attr type

Type of the address.

=cut

=attr value

When a value is unspecified, an implementation SHOULD automatically
assign an address matching the requested type if possible.

If an implementation does not support an empty value, they MUST set the
"Programmed" condition in status to False with a reason of "AddressNotAssigned".

Examples: `1.2.3.4`, `128::1`, `my-ip-address`.

=cut

1;
