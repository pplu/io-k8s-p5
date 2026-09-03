package IO::K8s::Cilium::V2::ICMPRule;
# ABSTRACT: ICMPRule is a list of ICMP fields.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s fields => ['+IO::K8s::Cilium::V2::ICMPField'];

=attr fields

Fields is a list of ICMP fields.

=cut

1;
