package IO::K8s::PrometheusOperator::V1::StorageSpec;
# ABSTRACT: storage defines the storage used by Prometheus.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s disableMountSubPath => Bool;
k8s emptyDir            => '+IO::K8s::PrometheusOperator::V1::EmptyDirVolumeSource';
k8s ephemeral           => '+IO::K8s::PrometheusOperator::V1::EphemeralVolumeSource';
k8s volumeClaimTemplate => '+IO::K8s::PrometheusOperator::V1::EmbeddedPersistentVolumeClaim';

=attr disableMountSubPath

disableMountSubPath deprecated: subPath usage will be removed in a future release.

=cut

=attr emptyDir

emptyDir to be used by the StatefulSet.
If specified, it takes precedence over `ephemeral` and `volumeClaimTemplate`.
More info: https://kubernetes.io/docs/concepts/storage/volumes/#emptydir

=cut

=attr ephemeral

ephemeral to be used by the StatefulSet.
This is a beta field in k8s 1.21 and GA in 1.15.
For lower versions, starting with k8s 1.19, it requires enabling the GenericEphemeralVolume feature gate.
More info: https://kubernetes.io/docs/concepts/storage/ephemeral-volumes/#generic-ephemeral-volumes

=cut

=attr volumeClaimTemplate

volumeClaimTemplate defines the PVC spec to be used by the Prometheus StatefulSets.
The easiest way to use a volume that cannot be automatically provisioned
is to use a label selector alongside manually created PersistentVolumes.

=cut

1;
