package IO::K8s::Cilium::V2alpha1::Port;
# ABSTRACT: Port Layer 4 port / protocol pair swagger:model Port
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name     => Str;
k8s port     => Int;
k8s protocol => Str;

=attr name

Optional layer 4 port name

=cut

=attr port

Layer 4 port number

=cut

=attr protocol

Layer 4 protocol
Enum: ["TCP","UDP","SCTP","ICMP","ICMPV6","ANY"]

=cut

1;
