package IO::K8s::Api::Storage::V1::CSINodeStatus;
# ABSTRACT: CSINodeStatus contains health and status information for storage on a node.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s storageHealth => ['Storage::V1::StorageHealth'];

=attr storageHealth

storageHealth contains backend health reports for CSI drivers registered on the node.

=cut

1;
