package IO::K8s::Api::Scheduling::V1beta1::DisruptionMode;
# ABSTRACT: DisruptionMode defines how individual entities within a group can be disrupted. Exactly one mode can be set.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s all => 'Scheduling::V1beta1::AllDisruptionMode';

=attr all

all specifies that all children can only be disrupted together.

=cut

k8s single => 'Scheduling::V1beta1::SingleDisruptionMode';

=attr single

single specifies that children can be disrupted independently from each other.

=cut

1;
