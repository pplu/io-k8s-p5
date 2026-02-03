package IO::K8s::Api::Storage::V1::VolumeAttachment;
# ABSTRACT: VolumeAttachment captures the intent to attach or detach the specified volume to/from the specified node. VolumeAttachment objects are non-namespaced.

use IO::K8s::APIObject;

=head1 DESCRIPTION

VolumeAttachment captures the intent to attach or detach the specified volume to/from the specified node.

VolumeAttachment objects are non-namespaced.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'Storage::V1::VolumeAttachmentSpec', 'required';

=attr spec

spec represents specification of the desired attach/detach volume behavior. Populated by the Kubernetes system.

=cut

k8s status => 'Storage::V1::VolumeAttachmentStatus';

=attr status

status represents status of the VolumeAttachment request. Populated by the entity completing the attach or detach operation, i.e. the external-attacher.

=cut

1;
