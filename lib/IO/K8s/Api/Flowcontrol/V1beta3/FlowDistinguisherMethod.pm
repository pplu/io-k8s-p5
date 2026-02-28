package IO::K8s::Api::Flowcontrol::V1beta3::FlowDistinguisherMethod;
# ABSTRACT: FlowDistinguisherMethod specifies the method of a flow distinguisher.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s type => Str, 'required';

=attr type

C<type> is the type of flow distinguisher method The supported types are "ByUser" and "ByNamespace". Required.

=cut

1;
