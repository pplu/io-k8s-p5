package IO::K8s::Cilium::V2::PrivateIPSet;
# ABSTRACT: PrivateIPSet is a nested struct in ecs response
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s primary              => Bool;
k8s 'private-ip-address' => Str;

=attr primary

No description in the upstream schema.

=cut

=attr private-ip-address

No description in the upstream schema.

=cut

1;
