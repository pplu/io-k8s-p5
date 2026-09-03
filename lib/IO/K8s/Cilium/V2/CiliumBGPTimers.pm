package IO::K8s::Cilium::V2::CiliumBGPTimers;
# ABSTRACT: Timers defines the BGP timers for the peer.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s connectRetryTimeSeconds => Int, { minimum => 1, maximum => 2147483647, default => 120 };
k8s holdTimeSeconds         => Int, { minimum => 3, maximum => 65535, default => 90 };
k8s keepAliveTimeSeconds    => Int, { minimum => 1, maximum => 65535, default => 30 };

=attr connectRetryTimeSeconds

ConnectRetryTimeSeconds defines the initial value for the BGP ConnectRetryTimer (RFC 4271, Section 8).

If not specified, defaults to 120 seconds.

=cut

=attr holdTimeSeconds

HoldTimeSeconds defines the initial value for the BGP HoldTimer (RFC 4271, Section 4.2).
Updating this value will cause a session reset.

If not specified, defaults to 90 seconds.

=cut

=attr keepAliveTimeSeconds

KeepaliveTimeSeconds defines the initial value for the BGP KeepaliveTimer (RFC 4271, Section 8).
It can not be larger than HoldTimeSeconds. Updating this value will cause a session reset.

If not specified, defaults to 30 seconds.

=cut

1;
