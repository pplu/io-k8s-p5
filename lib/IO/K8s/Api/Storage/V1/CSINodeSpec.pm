package IO::K8s::Api::Storage::V1::CSINodeSpec;
# ABSTRACT: CSINodeSpec holds information about the specification of all CSI drivers installed on a node
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s drivers => ['Storage::V1::CSINodeDriver'], 'required';

=attr drivers

drivers is a list of information of all CSI Drivers existing on a node. If all drivers in the list are uninstalled, this can become empty.

=cut

1;
