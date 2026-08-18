package IO::K8s::Api::Core::V1::PersistentVolumeClaimTemplate;
# ABSTRACT: PersistentVolumeClaimTemplate is used to produce PersistentVolumeClaim objects as part of an EphemeralVolumeSource.
our $VERSION = '1.108';
use IO::K8s::Resource;

=description

PersistentVolumeClaimTemplate is used to produce PersistentVolumeClaim objects as part of an EphemeralVolumeSource.

=cut

k8s metadata => 'Meta::V1::ObjectMeta';

=attr metadata

Standard object's metadata. See L<IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta>.

=cut

k8s spec => 'Core::V1::PersistentVolumeClaimSpec', 'required';

=attr spec

The specification for the PersistentVolumeClaim. The entire content is copied unchanged into the PVC that gets created from this template. The same fields as in a PersistentVolumeClaim are also valid here.

=cut

1;
