package IO::K8s::GatewayAPI::V1::ReferenceGrantSpec;
# ABSTRACT: Spec defines the desired state of ReferenceGrant.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s from => ['+IO::K8s::GatewayAPI::V1::ReferenceGrantFrom'], { required => 'schema' };
k8s to   => ['+IO::K8s::GatewayAPI::V1::ReferenceGrantTo'], { required => 'schema' };

=attr from

From describes the trusted namespaces and kinds that can reference the
resources described in "To". Each entry in this list MUST be considered
to be an additional place that references can be valid from, or to put
this another way, entries MUST be combined using OR.

Support: Core

=cut

=attr to

To describes the resources that may be referenced by the resources
described in "From". Each entry in this list MUST be considered to be an
additional place that references can be valid to, or to put this another
way, entries MUST be combined using OR.

Support: Core

=cut

1;
