package IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::StatusDetails;
# ABSTRACT: StatusDetails is a set of additional properties that MAY be set by the server to provide additional information about a response. The Reason field of a Status object defines what attributes will be set. Clients must ignore fields that do not match the defined type of each attribute, and should assume that any attribute may be empty, invalid, or under defined.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s causes => ['Meta::V1::StatusCause'];

=attr causes

The Causes array includes more details associated with the StatusReason failure. Not all StatusReasons may provide detailed causes.

=cut

k8s group => Str;

=attr group

The group attribute of the resource associated with the status StatusReason.

=cut

k8s kind => Str;

=attr kind

The kind attribute of the resource associated with the status StatusReason. On some operations may differ from the requested resource Kind. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds

=cut

k8s name => Str;

=attr name

The name attribute of the resource associated with the status StatusReason (when there is a single name which can be described).

=cut

k8s retryAfterSeconds => Int;

=attr retryAfterSeconds

If specified, the time in seconds before the operation should be retried. Some errors may indicate the client must take an alternate action - for those errors this field may indicate how long to wait before taking the alternate action.

=cut

k8s uid => Str;

=attr uid

UID of the resource. (when there is a single resource which can be described). More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names#uids

=cut

1;
