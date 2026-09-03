package IO::K8s::Cilium::V2::EgressGatewaySelector;
# ABSTRACT: EgressGatewaySelector
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s namespaceSelector => 'Meta::V1::LabelSelector';
k8s nodeSelector      => 'Meta::V1::LabelSelector';
k8s podSelector       => 'Meta::V1::LabelSelector';

=attr namespaceSelector

Selects Namespaces using cluster-scoped labels. This field follows standard label
selector semantics; if present but empty, it selects all namespaces.

=cut

=attr nodeSelector

This is a label selector which selects Pods by Node. This field follows standard label
selector semantics; if present but empty, it selects all nodes.

=cut

=attr podSelector

This is a label selector which selects Pods. This field follows standard label
selector semantics; if present but empty, it selects all pods.

=cut

1;
