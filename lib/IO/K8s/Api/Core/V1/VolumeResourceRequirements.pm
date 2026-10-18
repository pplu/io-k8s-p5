package IO::K8s::Api::Core::V1::VolumeResourceRequirements;
# ABSTRACT: VolumeResourceRequirements describes the storage resource requirements for a volume.
our $VERSION = '1.111';
use IO::K8s::Resource;

k8s limits => HashRef[Quantity];

=attr limits

Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/

=cut

k8s requests => HashRef[Quantity];

=attr requests

Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/

=cut

1;
