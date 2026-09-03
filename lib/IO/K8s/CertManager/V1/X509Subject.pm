package IO::K8s::CertManager::V1::X509Subject;
# ABSTRACT: Requested set of X509 certificate subject attributes.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s countries           => [Str];
k8s localities          => [Str];
k8s organizationalUnits => [Str];
k8s organizations       => [Str];
k8s postalCodes         => [Str];
k8s provinces           => [Str];
k8s serialNumber        => Str;
k8s streetAddresses     => [Str];

=attr countries

Countries to be used on the Certificate.

=cut

=attr localities

Cities to be used on the Certificate.

=cut

=attr organizationalUnits

Organizational Units to be used on the Certificate.

=cut

=attr organizations

Organizations to be used on the Certificate.

=cut

=attr postalCodes

Postal codes to be used on the Certificate.

=cut

=attr provinces

State/Provinces to be used on the Certificate.

=cut

=attr serialNumber

Serial number to be used on the Certificate.

=cut

=attr streetAddresses

Street addresses to be used on the Certificate.

=cut

1;
