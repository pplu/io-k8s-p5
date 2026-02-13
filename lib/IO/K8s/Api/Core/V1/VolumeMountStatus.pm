package IO::K8s::Api::Core::V1::VolumeMountStatus;
# ABSTRACT: VolumeMountStatus shows status of volume mounts.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s mountPath => Str, 'required';

=attr mountPath

MountPath corresponds to the original VolumeMount.

=cut

k8s name => Str, 'required';

=attr name

Name corresponds to the name of the original VolumeMount.

=cut

k8s readOnly => Bool;

=attr readOnly

ReadOnly corresponds to the original VolumeMount.

=cut

k8s recursiveReadOnly => Str;

=attr recursiveReadOnly

RecursiveReadOnly must be set to Disabled, Enabled, or unspecified (for non-readonly mounts). An IfPossible value in the original VolumeMount must be translated to Disabled or Enabled, depending on the mount result.

=cut

1;
