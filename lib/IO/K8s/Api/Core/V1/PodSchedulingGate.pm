package IO::K8s::Api::Core::V1::PodSchedulingGate;
# ABSTRACT: PodSchedulingGate is associated to a Pod to guard its scheduling.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

Name of the scheduling gate. Each scheduling gate must have a unique name field.

=cut

1;
