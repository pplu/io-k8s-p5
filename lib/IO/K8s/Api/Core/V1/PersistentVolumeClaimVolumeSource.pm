package IO::K8s::Api::Core::V1::PersistentVolumeClaimVolumeSource;
# ABSTRACT: PersistentVolumeClaimVolumeSource references the user's PVC in the same namespace. This volume finds the bound PV and mounts that volume for the pod. A PersistentVolumeClaimVolumeSource is, essentially, a wrapper around another type of volume that is owned by someone else (the system).
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s claimName => Str, 'required';

=attr claimName

claimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims

=cut

k8s readOnly => Bool;

=attr readOnly

readOnly Will force the ReadOnly setting in VolumeMounts. Default false.

=cut

1;
