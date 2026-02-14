package IO::K8s::Api::Core::V1::ConfigMapNodeConfigSource;
# ABSTRACT: ConfigMapNodeConfigSource contains the information to reference a ConfigMap as a config source for the Node. This API is deprecated since 1.22: https://git.k8s.io/enhancements/keps/sig-node/281-dynamic-kubelet-configuration
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s kubeletConfigKey => Str, 'required';

=attr kubeletConfigKey

KubeletConfigKey declares which key of the referenced ConfigMap corresponds to the KubeletConfiguration structure This field is required in all cases.

=cut

k8s name => Str, 'required';

=attr name

Name is the metadata.name of the referenced ConfigMap. This field is required in all cases.

=cut

k8s namespace => Str, 'required';

=attr namespace

Namespace is the metadata.namespace of the referenced ConfigMap. This field is required in all cases.

=cut

k8s resourceVersion => Str;

=attr resourceVersion

ResourceVersion is the metadata.ResourceVersion of the referenced ConfigMap. This field is forbidden in Node.Spec, and required in Node.Status.

=cut

k8s uid => Str;

=attr uid

UID is the metadata.UID of the referenced ConfigMap. This field is forbidden in Node.Spec, and required in Node.Status.

=cut

1;
