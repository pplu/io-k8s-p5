package IO::K8s::Api::Storage::V1beta1::VolumeAttributesClass;
# ABSTRACT: VolumeAttributesClass represents a specification of mutable volume attributes defined by the CSI driver. The class can be specified during dynamic provisioning of PersistentVolumeClaims, and changed in the PersistentVolumeClaim spec after provisioning.
our $VERSION = '1.005';
use IO::K8s::APIObject;

=description

VolumeAttributesClass represents a specification of mutable volume attributes defined by the CSI driver. The class can be specified during dynamic provisioning of PersistentVolumeClaims, and changed in the PersistentVolumeClaim spec after provisioning.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s driverName => Str, 'required';

=attr driverName

Name of the CSI driver This field is immutable.


=cut

k8s parameters => { Str => 1 };

=attr parameters

parameters hold volume attributes defined by the CSI driver. These values are opaque to the Kubernetes and are passed directly to the CSI driver. The underlying storage provider supports changing these attributes on an existing volume, however the parameters field itself is immutable. To invoke a volume update, a new VolumeAttributesClass should be created with new parameters, and the PersistentVolumeClaim should be updated to reference the new VolumeAttributesClass.

This field is required and must contain at least one key/value pair. The keys cannot be empty, and the maximum number of parameters is 512, with a cumulative max size of 256K. If the CSI driver rejects invalid parameters, the target PersistentVolumeClaim will be set to an "Infeasible" state in the modifyVolumeStatus field.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#volumeattributesclass-v1beta1-storage.k8s.io>


=cut
1;
