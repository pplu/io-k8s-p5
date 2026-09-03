package IO::K8s::GatewayAPI::V1beta1::LocalParametersReference;
# ABSTRACT: ParametersRef is a reference to a resource that contains the configuration parameters corresponding to the Gateway.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s group => Str, { required => 'schema', pattern => qr/^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };
k8s kind  => Str, { required => 'schema', pattern => qr/^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$/ };
k8s name  => Str, { required => 'schema' };

=attr group

Group is the group of the referent.

=cut

=attr kind

Kind is kind of the referent.

=cut

=attr name

Name is the name of the referent.

=cut

1;
