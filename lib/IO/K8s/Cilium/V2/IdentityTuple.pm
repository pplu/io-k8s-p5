package IO::K8s::Cilium::V2::IdentityTuple;
# ABSTRACT: IdentityTuple specifies a peer by identity, destination port and protocol.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s 'dest-port'       => Int;
k8s identity          => Int;
k8s 'identity-labels' => { Str => 1 };
k8s protocol          => Int;

=attr dest-port

No description in the upstream schema.

=cut

=attr identity

No description in the upstream schema.

=cut

=attr identity-labels

No description in the upstream schema.

=cut

=attr protocol

No description in the upstream schema.

=cut

1;
