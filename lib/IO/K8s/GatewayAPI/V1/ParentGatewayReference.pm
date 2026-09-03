package IO::K8s::GatewayAPI::V1::ParentGatewayReference;
# ABSTRACT: ParentRef references the Gateway that the listeners are attached to.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s group     => Str, { pattern => qr/^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/, default => 'gateway.networking.k8s.io' };
k8s kind      => Str, { pattern => qr/^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$/, default => 'Gateway' };
k8s name      => Str, { required => 'schema' };
k8s namespace => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?$/ };

=attr group

Group is the group of the referent.

=cut

=attr kind

Kind is kind of the referent. For example "Gateway".

=cut

=attr name

Name is the name of the referent.

=cut

=attr namespace

Namespace is the namespace of the referent.  If not present,
the namespace of the referent is assumed to be the same as
the namespace of the referring object.

=cut

1;
