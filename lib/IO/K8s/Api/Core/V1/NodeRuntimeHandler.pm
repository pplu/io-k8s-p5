package IO::K8s::Api::Core::V1::NodeRuntimeHandler;
# ABSTRACT: NodeRuntimeHandler is a set of runtime handler information.

use IO::K8s::Resource;

k8s features => 'Core::V1::NodeRuntimeHandlerFeatures';

=attr features

Supported features.

=cut

k8s name => Str;

=attr name

Runtime handler name. Empty for the default runtime handler.

=cut

1;
