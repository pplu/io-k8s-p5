package IO::K8s::CertManager::V1::ACMEIssuerDNS01ProviderRFC2136;
# ABSTRACT: Use RFC2136 ("Dynamic Updates in the Domain Name System") (https://datatracker.ietf.org/doc/rfc2136/) to manage DNS01 challenge records.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s nameserver          => Str, { required => 'schema' };
k8s protocol            => Str, { enum => [qw(TCP UDP)] };
k8s tsigAlgorithm       => Str;
k8s tsigKeyName         => Str;
k8s tsigSecretSecretRef => '+IO::K8s::CertManager::V1::SecretKeySelector';

=attr nameserver

The IP address or hostname of an authoritative DNS server supporting
RFC2136 in the form host:port. If the host is an IPv6 address it must be
enclosed in square brackets (e.g [2001:db8::1]); port is optional.
This field is required.

=cut

=attr protocol

Protocol to use for dynamic DNS update queries. Valid values are (case-sensitive) ``TCP`` and ``UDP``; ``UDP`` (default).

=cut

=attr tsigAlgorithm

The TSIG Algorithm configured in the DNS supporting RFC2136. Used only
when ``tsigSecretSecretRef`` and ``tsigKeyName`` are defined.
Supported values are (case-insensitive): ``HMACMD5`` (default),
``HMACSHA1``, ``HMACSHA256`` or ``HMACSHA512``.

=cut

=attr tsigKeyName

The TSIG Key name configured in the DNS.
If ``tsigSecretSecretRef`` is defined, this field is required.

=cut

=attr tsigSecretSecretRef

The name of the secret containing the TSIG value.
If ``tsigKeyName`` is defined, this field is required.

=cut

1;
