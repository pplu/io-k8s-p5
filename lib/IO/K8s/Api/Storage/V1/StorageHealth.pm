package IO::K8s::Api::Storage::V1::StorageHealth;
# ABSTRACT: StorageHealth contains storage backend health reported by a CSI driver on a node.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s healthConditions => ['Storage::V1::StorageHealthCondition'];

=attr healthConditions

healthConditions are the adverse storage backend conditions reported by the CSI driver. At most 16 conditions may be reported.

=cut

k8s name => Str, 'required';

=attr name

name is the CSI driver name, matching CSINodeDriver.name.

=cut

1;
