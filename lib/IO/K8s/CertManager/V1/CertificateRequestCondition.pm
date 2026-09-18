package IO::K8s::CertManager::V1::CertificateRequestCondition;
# ABSTRACT: CertificateRequestCondition contains condition information for a CertificateRequest.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s lastTransitionTime => Time;

=attr lastTransitionTime

LastTransitionTime is the timestamp corresponding to the last status
change of this condition.

=cut

k8s message => Str;

=attr message

Message is a human readable description of the details of the last
transition, complementing reason.

=cut

k8s reason => Str;

=attr reason

Reason is a brief machine readable explanation for the condition's last
transition.

=cut

k8s status => Str, 'required';

=attr status

Status of the condition, one of (`True`, `False`, `Unknown`).

=cut

k8s type => Str, 'required';

=attr type

Type of the condition, known values are (`Ready`, `InvalidRequest`,
`Approved`, `Denied`).

=cut

1;
