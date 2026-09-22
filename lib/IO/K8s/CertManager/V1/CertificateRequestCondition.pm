package IO::K8s::CertManager::V1::CertificateRequestCondition;
# ABSTRACT: CertificateRequestCondition contains condition information for a CertificateRequest.
our $VERSION = '1.109';
use IO::K8s::Resource;

k8s lastTransitionTime => Time;
k8s message            => Str;
k8s reason             => Str;
k8s status             => Str, { required => 'schema', enum => [qw(True False Unknown)] };
k8s type               => Str, { required => 'schema' };

=attr lastTransitionTime

LastTransitionTime is the timestamp corresponding to the last status
change of this condition.

=cut

=attr message

Message is a human readable description of the details of the last
transition, complementing reason.

=cut

=attr reason

Reason is a brief machine readable explanation for the condition's last
transition.

=cut

=attr status

Status of the condition, one of (`True`, `False`, `Unknown`).

=cut

=attr type

Type of the condition, known values are (`Ready`, `InvalidRequest`,
`Approved`, `Denied`).

=cut

1;
