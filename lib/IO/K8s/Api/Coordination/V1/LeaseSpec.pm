package IO::K8s::Api::Coordination::V1::LeaseSpec;
# ABSTRACT: LeaseSpec is a specification of a Lease.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s acquireTime => Time;

=attr acquireTime

acquireTime is a time when the current lease was acquired.

=cut

k8s holderIdentity => Str;

=attr holderIdentity

holderIdentity contains the identity of the holder of a current lease. If Coordinated Leader Election is used, the holder identity must be equal to the elected LeaseCandidate.metadata.name field.

=cut

k8s leaseDurationSeconds => Int;

=attr leaseDurationSeconds

leaseDurationSeconds is a duration that candidates for a lease need to wait to force acquire it. This is measured against the time of last observed renewTime.

=cut

k8s leaseTransitions => Int;

=attr leaseTransitions

leaseTransitions is the number of transitions of a lease between holders.

=cut

k8s preferredHolder => Str;

=attr preferredHolder

PreferredHolder signals to a lease holder that the lease has a more optimal holder and should be given up. This field can only be set if Strategy is also set.

=cut

k8s renewTime => Time;

=attr renewTime

renewTime is a time when the current holder of a lease has last updated the lease.

=cut

k8s strategy => Str;

=attr strategy

Strategy indicates the strategy for picking the leader for coordinated leader election. If the field is not specified, there is no active coordination for this lease. (Alpha) Using this field requires the CoordinatedLeaderElection feature gate to be enabled.

=cut

1;
