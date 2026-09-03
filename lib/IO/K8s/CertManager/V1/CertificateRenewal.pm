package IO::K8s::CertManager::V1::CertificateRenewal;
# ABSTRACT: `renewal` allows configuration of how your certificate is renewed.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s policy  => Str, { enum => [qw(RenewBefore Disabled)] };
k8s windows => ['+IO::K8s::CertManager::V1::CertificateRenewalWindows'];

=attr policy

`policy` must be one of `Disabled`, `RenewBefore`.

=cut

=attr windows

`windows` mentions the behavior of when the renewal must happen.

=cut

1;
