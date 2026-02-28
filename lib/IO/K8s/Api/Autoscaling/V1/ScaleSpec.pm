package IO::K8s::Api::Autoscaling::V1::ScaleSpec;
# ABSTRACT: ScaleSpec describes the attributes of a scale subresource.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s replicas => Int;

=attr replicas

replicas is the desired number of instances for the scaled object.

=cut

1;
