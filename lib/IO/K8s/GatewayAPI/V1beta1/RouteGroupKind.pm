package IO::K8s::GatewayAPI::V1beta1::RouteGroupKind;
# ABSTRACT: RouteGroupKind indicates the group and kind of a Route resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s group => Str, { pattern => qr/^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/, default => 'gateway.networking.k8s.io' };
k8s kind  => Str, { required => 'schema', pattern => qr/^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$/ };

=attr group

Group is the group of the Route.

=cut

=attr kind

Kind is the kind of the Route.

=cut

1;
