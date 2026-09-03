package IO::K8s::Cilium::V2alpha1::CiliumBGPNeighborGracefulRestart;
# ABSTRACT: GracefulRestart defines graceful restart parameters which are negotiated with this peer.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s enabled            => Bool, { required => 'schema' };
k8s restartTimeSeconds => Int, { minimum => 1, maximum => 4095, default => 120 };

=attr enabled

Enabled flag, when set enables graceful restart capability.

=cut

=attr restartTimeSeconds

RestartTimeSeconds is the estimated time it will take for the BGP
session to be re-established with peer after a restart.
After this period, peer will remove stale routes. This is
described RFC 4724 section 4.2.

=cut

1;
