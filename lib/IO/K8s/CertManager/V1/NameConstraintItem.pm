package IO::K8s::CertManager::V1::NameConstraintItem;
# ABSTRACT: Permitted contains the constraints in which the names must be located.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s dnsDomains     => [Str];
k8s emailAddresses => [Str];
k8s ipRanges       => [Str];
k8s uriDomains     => [Str];

=attr dnsDomains

DNSDomains is a list of DNS domains that are permitted or excluded.

=cut

=attr emailAddresses

EmailAddresses is a list of Email Addresses that are permitted or excluded.

=cut

=attr ipRanges

IPRanges is a list of IP Ranges that are permitted or excluded.
This should be a valid CIDR notation.

=cut

=attr uriDomains

URIDomains is a list of URI domains that are permitted or excluded.

=cut

1;
