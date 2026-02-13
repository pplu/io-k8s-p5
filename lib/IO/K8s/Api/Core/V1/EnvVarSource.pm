package IO::K8s::Api::Core::V1::EnvVarSource;
# ABSTRACT: EnvVarSource represents a source for the value of an EnvVar.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s configMapKeyRef => 'Core::V1::ConfigMapKeySelector';

=attr configMapKeyRef

Selects a key of a ConfigMap.

=cut

k8s fieldRef => 'Core::V1::ObjectFieldSelector';

=attr fieldRef

Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs.

=cut

k8s resourceFieldRef => 'Core::V1::ResourceFieldSelector';

=attr resourceFieldRef

Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported.

=cut

k8s secretKeyRef => 'Core::V1::SecretKeySelector';

=attr secretKeyRef

Selects a key of a secret in the pod's namespace

=cut

1;
