package IO::K8s::Api::Flowcontrol::V1::LimitResponse;
# ABSTRACT: LimitResponse defines how to handle requests that can not be executed right now.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s queuing => 'Flowcontrol::V1::QueuingConfiguration';

=attr queuing

`queuing` holds the configuration parameters for queuing. This field may be non-empty only if `type` is `"Queue"`.

=cut

k8s type => Str, 'required';

=attr type

`type` is "Queue" or "Reject". "Queue" means that requests that can not be executed upon arrival are held in a queue until they can be executed or a queuing limit is reached. "Reject" means that requests that can not be executed upon arrival are rejected. Required.

=cut

1;
