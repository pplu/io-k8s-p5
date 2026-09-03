package IO::K8s::CertManager::V1::ACMERenewalWindow;
# ABSTRACT: SuggestedWindow is the suggested renewal window as returned by the ACME server in accordance with RFC 9773.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s end   => Time, { required => 'schema' };
k8s start => Time, { required => 'schema' };

=attr end

End is the end of the suggested renewal window.

=cut

=attr start

Start is the start of the suggested renewal window.

=cut

1;
