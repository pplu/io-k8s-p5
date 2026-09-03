package IO::K8s::GatewayAPI::V1beta1::LocalObjectReference;
# ABSTRACT: ExtensionRef is an optional, implementation-specific extension to the "filter" behavior.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s group => Str, { required => 'schema', pattern => qr/^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };
k8s kind  => Str, { required => 'schema', pattern => qr/^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$/ };
k8s name  => Str, { required => 'schema' };

=attr group

Group is the group of the referent. For example, "gateway.networking.k8s.io".
When unspecified or empty string, core API group is inferred.

=cut

=attr kind

Kind is kind of the referent. For example "HTTPRoute" or "Service".

=cut

=attr name

Name is the name of the referent.

=cut

1;
