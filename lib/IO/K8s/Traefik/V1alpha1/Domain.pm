package IO::K8s::Traefik::V1alpha1::Domain;
# ABSTRACT: Domain is the domain definition for the DefaultCertificate.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s main => Str;
k8s sans => [Str];

=attr main

Main defines the main domain name.

=cut

=attr sans

SANs defines the subject alternative domain names.

=cut

1;
