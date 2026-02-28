package IO::K8s::Api::Discovery::V1::EndpointConditions;
# ABSTRACT: EndpointConditions represents the current condition of an endpoint.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s ready => Bool;

=attr ready

ready indicates that this endpoint is prepared to receive traffic, according to whatever system is managing the endpoint. A nil value indicates an unknown state. In most cases consumers should interpret this unknown state as ready. For compatibility reasons, ready should never be "true" for terminating endpoints, except when the normal readiness behavior is being explicitly overridden, for example when the associated Service has set the publishNotReadyAddresses flag.

=cut

k8s serving => Bool;

=attr serving

serving is identical to ready except that it is set regardless of the terminating state of endpoints. This condition should be set to true for a ready endpoint that is terminating. If nil, consumers should defer to the ready condition.

=cut

k8s terminating => Bool;

=attr terminating

terminating indicates that this endpoint is terminating. A nil value indicates an unknown state. Consumers should interpret this unknown state to mean that the endpoint is not terminating.

=cut

1;
