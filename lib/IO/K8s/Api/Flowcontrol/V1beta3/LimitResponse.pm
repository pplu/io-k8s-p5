package IO::K8s::Api::Flowcontrol::V1beta3::LimitResponse;
# ABSTRACT: LimitResponse defines how to handle requests that can not be executed right now.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s queuing => 'Flowcontrol::V1beta3::QueuingConfiguration';

=attr queuing

C<queuing> holds the configuration parameters for queuing. This field may be non-empty only if C<type> is C<"Queue">.

=cut

k8s type => Str, 'required';

=attr type

C<type> is "Queue" or "Reject". "Queue" means that requests that can not be executed upon arrival are held in a queue until they can be executed or a queuing limit is reached. "Reject" means that requests that can not be executed upon arrival are rejected. Required.

=cut

1;
