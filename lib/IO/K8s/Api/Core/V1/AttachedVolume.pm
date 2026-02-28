package IO::K8s::Api::Core::V1::AttachedVolume;
# ABSTRACT: AttachedVolume describes a volume attached to a node
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s devicePath => Str, 'required';

=attr devicePath

DevicePath represents the device path where the volume should be available

=cut

k8s name => Str, 'required';

=attr name

Name of the attached volume

=cut

1;
