package IO::K8s::Api::Coordination::V1alpha2::LeaseCandidateSpec;
# ABSTRACT: LeaseCandidateSpec is a specification of a Lease.
our $VERSION = '1.106';
use IO::K8s::Resource;

k8s binaryVersion => Str, 'required';

=attr binaryVersion

BinaryVersion is the binary version. It must be in a semver format without leading C<v>. This field is required.

=cut

k8s emulationVersion => Str;

=attr emulationVersion

EmulationVersion is the emulation version. It must be in a semver format without leading C<v>. EmulationVersion must be less than or equal to BinaryVersion. This field is required when strategy is "OldestEmulationVersion"

=cut

k8s leaseName => Str, 'required';

=attr leaseName

LeaseName is the name of the lease for which this candidate is contending. This field is immutable.

=cut

k8s pingTime => Time;

=attr pingTime

PingTime is the last time that the server has requested the LeaseCandidate to renew. It is only done during leader election to check if any LeaseCandidates have become ineligible. When PingTime is updated, the LeaseCandidate will respond by updating RenewTime.

=cut

k8s renewTime => Time;

=attr renewTime

RenewTime is the time that the LeaseCandidate was last updated. Any time a Lease needs to do leader election, the PingTime field is updated to signal to the LeaseCandidate that they should update the RenewTime. Old LeaseCandidate objects are also garbage collected if it has been hours since the last renew. The PingTime field is updated regularly to prevent garbage collection for still active LeaseCandidates.

=cut

k8s strategy => Str, 'required';

=attr strategy

Strategy is the strategy that coordinated leader election will use for picking the leader. If multiple candidates for the same Lease return different strategies, the strategy provided by the candidate with the latest BinaryVersion will be used. If there is still conflict, this is a user error and coordinated leader election will not operate the Lease until resolved.

=cut

1;
