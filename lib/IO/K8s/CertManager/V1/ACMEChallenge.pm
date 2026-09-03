package IO::K8s::CertManager::V1::ACMEChallenge;
# ABSTRACT: Challenge specifies a challenge offered by the ACME server for an Order.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s token => Str, { required => 'schema' };
k8s type  => Str, { required => 'schema' };
k8s url   => Str, { required => 'schema' };

=attr token

Token is the token that must be presented for this challenge.
This is used to compute the 'key' that must also be presented.

=cut

=attr type

Type is the type of challenge being offered, e.g., 'http-01', 'dns-01',
'tls-sni-01', etc.
This is the raw value retrieved from the ACME server.
Only 'http-01' and 'dns-01' are supported by cert-manager, other values
will be ignored.

=cut

=attr url

URL is the URL of this challenge. It can be used to retrieve additional
metadata about the Challenge from the ACME server.

=cut

1;
