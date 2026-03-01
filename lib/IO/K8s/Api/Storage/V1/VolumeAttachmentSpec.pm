package IO::K8s::Api::Storage::V1::VolumeAttachmentSpec;
# ABSTRACT: VolumeAttachmentSpec is the specification of a VolumeAttachment request.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s attacher => Str, 'required';

=attr attacher

attacher indicates the name of the volume driver that MUST handle this request. This is the name returned by GetPluginName().

=cut

k8s nodeName => Str, 'required';

=attr nodeName

nodeName represents the node that the volume should be attached to.

=cut

k8s source => 'Storage::V1::VolumeAttachmentSource', 'required';

=attr source

source represents the volume that should be attached.

=cut

1;
