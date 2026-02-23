package IO::K8s::Api::Storage::V1::VolumeAttachmentSource;
# ABSTRACT: VolumeAttachmentSource represents a volume that should be attached. Right now only PersistenVolumes can be attached via external attacher, in future we may allow also inline volumes in pods. Exactly one member can be set.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s inlineVolumeSpec => 'Core::V1::PersistentVolumeSpec';

=attr inlineVolumeSpec

inlineVolumeSpec contains all the information necessary to attach a persistent volume defined by a pod's inline VolumeSource. This field is populated only for the CSIMigration feature. It contains translated fields from a pod's inline VolumeSource to a PersistentVolumeSpec. This field is beta-level and is only honored by servers that enabled the CSIMigration feature.

=cut

k8s persistentVolumeName => Str;

=attr persistentVolumeName

persistentVolumeName represents the name of the persistent volume to attach.

=cut

1;
