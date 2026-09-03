package IO::K8s::Cilium::V2::EndpointIdentity;
# ABSTRACT: Identity is the security identity associated with the endpoint
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s id     => Int;
k8s labels => [Str];

=attr id

ID is the numeric identity of the endpoint

=cut

=attr labels

Labels is the list of labels associated with the identity

=cut

1;
