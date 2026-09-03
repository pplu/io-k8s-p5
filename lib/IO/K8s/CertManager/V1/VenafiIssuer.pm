package IO::K8s::CertManager::V1::VenafiIssuer;
# ABSTRACT: Venafi configures this issuer to sign certificates using a CyberArk Certificate Manager Self-Hosted or SaaS policy zone.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s cloud => '+IO::K8s::CertManager::V1::VenafiCloud';
k8s ngts  => '+IO::K8s::CertManager::V1::VenafiNGTS';
k8s tpp   => '+IO::K8s::CertManager::V1::VenafiTPP';
k8s zone  => Str, { required => 'schema' };

=attr cloud

Cloud specifies the CyberArk Certificate Manager SaaS configuration settings.
Only one of CyberArk Certificate Manager may be specified.

=cut

=attr ngts

NGTS specifies Palo Alto Networks Next Generation Trust Services (NGTS) configuration
using OAuth 2.0 Client Credentials. Only one of tpp, cloud, or ngts may be specified.

=cut

=attr tpp

TPP specifies CyberArk Certificate Manager Self-Hosted configuration settings.
Only one of CyberArk Certificate Manager may be specified.

=cut

=attr zone

Zone is the Certificate Manager Policy Zone to use for this issuer.
All requests made to the Certificate Manager platform will be restricted by the named
zone policy.
This field is required.

=cut

1;
