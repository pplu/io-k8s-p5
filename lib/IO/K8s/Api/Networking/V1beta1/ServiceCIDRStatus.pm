package IO::K8s::Api::Networking::V1beta1::ServiceCIDRStatus;
# ABSTRACT: ServiceCIDRStatus describes the current state of the ServiceCIDR.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s conditions => ['Meta::V1::Condition'];

=attr conditions

conditions holds an array of metav1.Condition that describe the state of the ServiceCIDR. Current service state

=cut

1;
