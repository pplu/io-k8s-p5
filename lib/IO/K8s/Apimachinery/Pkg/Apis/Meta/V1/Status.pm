package IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::Status;
# ABSTRACT: Status is a return value for calls that don't return other objects.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s apiVersion => Str;

=attr apiVersion

APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources

=cut

k8s code => Int;

=attr code

Suggested HTTP return code for this status, 0 if not set.

=cut

k8s details => 'Meta::V1::StatusDetails';

=attr details

Extended data associated with the reason.  Each reason may define its own extended details. This field is optional and the data returned is not guaranteed to conform to any schema except that defined by the reason type.

=cut

k8s kind => Str;

=attr kind

Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds

=cut

k8s message => Str;

=attr message

A human-readable description of the status of this operation.

=cut

k8s metadata => 'Meta::V1::ListMeta';

=attr metadata

Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds

=cut

k8s reason => Str;

=attr reason

A machine-readable description of why this operation is in the "Failure" status. If this value is empty there is no information available. A Reason clarifies an HTTP status code but does not override it.

=cut

k8s status => Str;

=attr status

Status of the operation. One of: "Success" or "Failure". More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

1;
