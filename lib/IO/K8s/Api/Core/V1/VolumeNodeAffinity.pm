package IO::K8s::Api::Core::V1::VolumeNodeAffinity;
# ABSTRACT: VolumeNodeAffinity defines constraints that limit what nodes this volume can be accessed from.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s required => 'Core::V1::NodeSelector';

=attr required

required specifies hard node constraints that must be met.

=cut

1;
