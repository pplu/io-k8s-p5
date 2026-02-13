package IO::K8s::Api::Core::V1::NodeConfigSource;
# ABSTRACT: NodeConfigSource specifies a source of node configuration. Exactly one subfield (excluding metadata) must be non-nil. This API is deprecated since 1.22
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s configMap => 'Core::V1::ConfigMapNodeConfigSource';

=attr configMap

ConfigMap is a reference to a Node's ConfigMap

=cut

1;
