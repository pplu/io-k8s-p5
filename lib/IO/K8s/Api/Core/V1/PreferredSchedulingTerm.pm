package IO::K8s::Api::Core::V1::PreferredSchedulingTerm;
# ABSTRACT: An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op).
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s preference => 'Core::V1::NodeSelectorTerm', 'required';

=attr preference

A node selector term, associated with the corresponding weight.

=cut

k8s weight => Int, 'required';

=attr weight

Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100.

=cut

1;
