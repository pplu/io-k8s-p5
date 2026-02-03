package IO::K8s::Api::Core::V1::PersistentVolumeClaimTemplate;
# ABSTRACT: PersistentVolumeClaimTemplate is used to produce PersistentVolumeClaim objects as part of an EphemeralVolumeSource.

use IO::K8s::APIObject;

=head1 DESCRIPTION

PersistentVolumeClaimTemplate is used to produce PersistentVolumeClaim objects as part of an EphemeralVolumeSource.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'Core::V1::PersistentVolumeClaimSpec', 'required';

=attr spec

The specification for the PersistentVolumeClaim. The entire content is copied unchanged into the PVC that gets created from this template. The same fields as in a PersistentVolumeClaim are also valid here.

=cut

1;
