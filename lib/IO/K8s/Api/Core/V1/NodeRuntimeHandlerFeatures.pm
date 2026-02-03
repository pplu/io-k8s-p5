package IO::K8s::Api::Core::V1::NodeRuntimeHandlerFeatures;
# ABSTRACT: NodeRuntimeHandlerFeatures is a set of features implemented by the runtime handler.

use IO::K8s::Resource;

k8s recursiveReadOnlyMounts => Bool;

=attr recursiveReadOnlyMounts

RecursiveReadOnlyMounts is set to true if the runtime handler supports RecursiveReadOnlyMounts.

=cut

k8s userNamespaces => Bool;

=attr userNamespaces

UserNamespaces is set to true if the runtime handler supports UserNamespaces, including for volumes.

=cut

1;
