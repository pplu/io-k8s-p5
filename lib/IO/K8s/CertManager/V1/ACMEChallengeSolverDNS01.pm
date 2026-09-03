package IO::K8s::CertManager::V1::ACMEChallengeSolverDNS01;
# ABSTRACT: Configures cert-manager to attempt to complete authorizations by performing the DNS01 challenge flow.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s acmeDNS       => '+IO::K8s::CertManager::V1::ACMEIssuerDNS01ProviderAcmeDNS';
k8s akamai        => '+IO::K8s::CertManager::V1::ACMEIssuerDNS01ProviderAkamai';
k8s azureDNS      => '+IO::K8s::CertManager::V1::ACMEIssuerDNS01ProviderAzureDNS';
k8s cloudDNS      => '+IO::K8s::CertManager::V1::ACMEIssuerDNS01ProviderCloudDNS';
k8s cloudflare    => '+IO::K8s::CertManager::V1::ACMEIssuerDNS01ProviderCloudflare';
k8s cnameStrategy => Str, { enum => [qw(None Follow)] };
k8s digitalocean  => '+IO::K8s::CertManager::V1::ACMEIssuerDNS01ProviderDigitalOcean';
k8s rfc2136       => '+IO::K8s::CertManager::V1::ACMEIssuerDNS01ProviderRFC2136';
k8s route53       => '+IO::K8s::CertManager::V1::ACMEIssuerDNS01ProviderRoute53';
k8s webhook       => '+IO::K8s::CertManager::V1::ACMEIssuerDNS01ProviderWebhook';

=attr acmeDNS

Use the 'ACME DNS' (https://github.com/joohoi/acme-dns) API to manage
DNS01 challenge records.

=cut

=attr akamai

Use the Akamai DNS zone management API to manage DNS01 challenge records.

=cut

=attr azureDNS

Use the Microsoft Azure DNS API to manage DNS01 challenge records.

=cut

=attr cloudDNS

Use the Google Cloud DNS API to manage DNS01 challenge records.

=cut

=attr cloudflare

Use the Cloudflare API to manage DNS01 challenge records.

=cut

=attr cnameStrategy

CNAMEStrategy configures how the DNS01 provider should handle CNAME
records when found in DNS zones.

=cut

=attr digitalocean

Use the DigitalOcean DNS API to manage DNS01 challenge records.

=cut

=attr rfc2136

Use RFC2136 ("Dynamic Updates in the Domain Name System") (https://datatracker.ietf.org/doc/rfc2136/)
to manage DNS01 challenge records.

=cut

=attr route53

Use the AWS Route53 API to manage DNS01 challenge records.

=cut

=attr webhook

Configure an external webhook based DNS01 challenge solver to manage
DNS01 challenge records.

=cut

1;
