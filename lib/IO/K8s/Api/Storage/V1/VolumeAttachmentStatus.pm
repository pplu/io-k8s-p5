package IO::K8s::Api::Storage::V1::VolumeAttachmentStatus;
# ABSTRACT: VolumeAttachmentStatus is the status of a VolumeAttachment request.

use IO::K8s::Resource;

k8s attachError => 'Storage::V1::VolumeError';

=attr attachError

attachError represents the last error encountered during attach operation, if any. This field must only be set by the entity completing the attach operation, i.e. the external-attacher.

=cut

k8s attached => Bool, 'required';

=attr attached

attached indicates the volume is successfully attached. This field must only be set by the entity completing the attach operation, i.e. the external-attacher.

=cut

k8s attachmentMetadata => { Str => 1 };

=attr attachmentMetadata

attachmentMetadata is populated with any information returned by the attach operation, upon successful attach, that must be passed into subsequent WaitForAttach or Mount calls. This field must only be set by the entity completing the attach operation, i.e. the external-attacher.

=cut

k8s detachError => 'Storage::V1::VolumeError';

=attr detachError

detachError represents the last error encountered during detach operation, if any. This field must only be set by the entity completing the detach operation, i.e. the external-attacher.

=cut

1;
