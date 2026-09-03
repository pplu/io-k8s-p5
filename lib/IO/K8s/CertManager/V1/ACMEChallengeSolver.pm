package IO::K8s::CertManager::V1::ACMEChallengeSolver;
# ABSTRACT: An ACMEChallengeSolver describes how to solve ACME challenges for the issuer it is part of.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s dns01                  => '+IO::K8s::CertManager::V1::ACMEChallengeSolverDNS01';
k8s http01                 => '+IO::K8s::CertManager::V1::ACMEChallengeSolverHTTP01';
k8s selector               => '+IO::K8s::CertManager::V1::CertificateDNSNameSelector';
k8s waitInsteadOfSelfCheck => Str;

=attr dns01

Configures cert-manager to attempt to complete authorizations by
performing the DNS01 challenge flow.

=cut

=attr http01

Configures cert-manager to attempt to complete authorizations by
performing the HTTP01 challenge flow.
It is not possible to obtain certificates for wildcard domain names
(e.g., `*.example.com`) using the HTTP01 challenge mechanism.

=cut

=attr selector

Selector selects a set of DNSNames on the Certificate resource that
should be solved using this challenge solver.
If not specified, the solver will be treated as the 'default' solver
with the lowest priority, i.e. if any other solver has a more specific
match, it will be used instead.

=cut

=attr waitInsteadOfSelfCheck

WaitInsteadOfSelfCheck, if set, skips cert-manager's self-check and
instead waits this long after presentation before asking the ACME server
to validate the challenge.

This is an advanced escape hatch for environments where cert-manager's
self-check cannot succeed from its own network or DNS viewpoint even
though the ACME server can still validate successfully, for example due
to split-horizon DNS or NAT hairpinning.

A value of 0 skips the self-check and asks the ACME server to validate
immediately after presentation, relying on the ACME server's own
validation retries (RFC 8555 section 8.2) to succeed once the challenge
has propagated. A negative duration is rejected.
Value must be in units accepted by Go time.ParseDuration https://golang.org/pkg/time/#ParseDuration,
for example `30s` or `2m`.

=cut

1;
