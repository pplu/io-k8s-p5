package IO::K8s::Api::Scheduling::V1beta1::CompositeDisruptionMode;
# ABSTRACT: CompositeDisruptionMode defines how individual entities within a composite pod group can be disrupted. Exactly one mode must be set.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s all => 'Scheduling::V1beta1::AllCompositeDisruptionMode';

=attr all

all specifies that all children groups can only be disrupted together.

=cut

k8s single => 'Scheduling::V1beta1::SingleCompositeDisruptionMode';

=attr single

single specifies that children groups can be disrupted independently from each other.

=cut

1;
