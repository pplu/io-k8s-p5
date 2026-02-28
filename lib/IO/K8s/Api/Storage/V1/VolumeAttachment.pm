package IO::K8s::Api::Storage::V1::VolumeAttachment;
# ABSTRACT: VolumeAttachment captures the intent to attach or detach the specified volume to/from the specified node. VolumeAttachment objects are non-namespaced.
our $VERSION = '1.004';
use IO::K8s::APIObject;

=description

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
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#volumeattachment-v1-storage.k8s.io>


=cut
1;
