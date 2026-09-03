package IO::K8s::CertManager::V1::CertificateACMEARIStatus;
# ABSTRACT: ARI stores the ACME Renewal Information that is fetched from the ACME server in accordance with RFC 9773.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s explanationURL  => Str;
k8s lastChecked     => Time;
k8s lastError       => Str;
k8s nextCheck       => Time;
k8s suggestedWindow => '+IO::K8s::CertManager::V1::ACMERenewalWindow';

=attr explanationURL

ExplanationURL is a human-readable URL that may explain why the suggested window
has its current value.

=cut

=attr lastChecked

LastChecked is the time at which the ACME server was last checked for renewal information.

=cut

=attr lastError

LastError is the last error encountered when checking the ACME server for renewal information, if any.

=cut

=attr nextCheck

NextCheck is the time at which the ACME server will next be checked for renewal information.

=cut

=attr suggestedWindow

SuggestedWindow is the suggested renewal window as returned by the ACME server in accordance with RFC 9773.

=cut

1;
