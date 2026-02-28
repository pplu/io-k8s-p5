package IO::K8s::Api::Certificates::V1::CertificateSigningRequestCondition;
# ABSTRACT: CertificateSigningRequestCondition describes a condition of a CertificateSigningRequest object
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s lastTransitionTime => Time;

=attr lastTransitionTime

lastTransitionTime is the time the condition last transitioned from one status to another. If unset, when a new condition type is added or an existing condition's status is changed, the server defaults this to the current time.

=cut

k8s lastUpdateTime => Time;

=attr lastUpdateTime

lastUpdateTime is the time of the last update to this condition

=cut

k8s message => Str;

=attr message

message contains a human readable message with details about the request state

=cut

k8s reason => Str;

=attr reason

reason indicates a brief reason for the request state

=cut

k8s status => Str, 'required';

=attr status

status of the condition, one of True, False, Unknown. Approved, Denied, and Failed conditions may not be "False" or "Unknown".

=cut

k8s type => Str, 'required';

=attr type

type of the condition. Known conditions are "Approved", "Denied", and "Failed".

An "Approved" condition is added via the /approval subresource, indicating the request was approved and should be issued by the signer.

A "Denied" condition is added via the /approval subresource, indicating the request was denied and should not be issued by the signer.

A "Failed" condition is added via the /status subresource, indicating the signer failed to issue the certificate.

Approved and Denied conditions are mutually exclusive. Approved, Denied, and Failed conditions cannot be removed once added.

Only one condition of a given type is allowed.

=cut

1;
