package IO::K8s::PrometheusOperator::V1::EmbeddedPersistentVolumeClaim;
# ABSTRACT: volumeClaimTemplate defines the PVC spec to be used by the Prometheus StatefulSets.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiVersion => Str;
k8s kind       => Str;
k8s metadata   => '+IO::K8s::PrometheusOperator::V1::EmbeddedObjectMetadata';
k8s spec       => 'Core::V1::PersistentVolumeClaimSpec';
k8s status     => '+IO::K8s::PrometheusOperator::V1::PersistentVolumeClaimStatus';

=attr apiVersion

APIVersion defines the versioned schema of this representation of an object.
Servers should convert recognized schemas to the latest internal value, and
may reject unrecognized values.
More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources

=cut

=attr kind

Kind is a string value representing the REST resource this object represents.
Servers may infer this from the endpoint the client submits requests to.
Cannot be updated.
In CamelCase.
More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds

=cut

=attr metadata

metadata defines EmbeddedMetadata contains metadata relevant to an EmbeddedResource.

=cut

=attr spec

spec defines the specification of the  characteristics of a volume requested by a pod author.
More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims

=cut

=attr status

status is deprecated: this field is never set.

=cut

1;
