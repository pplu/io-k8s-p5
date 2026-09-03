package IO::K8s::Cilium::V2alpha1::CiliumBGPTimersState;
# ABSTRACT: Timers is the state of the negotiated BGP timers for this peer.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s appliedHoldTimeSeconds  => Int;
k8s appliedKeepaliveSeconds => Int;

=attr appliedHoldTimeSeconds

AppliedHoldTimeSeconds is the negotiated hold time for this peer.

=cut

=attr appliedKeepaliveSeconds

AppliedKeepaliveSeconds is the negotiated keepalive time for this peer.

=cut

1;
