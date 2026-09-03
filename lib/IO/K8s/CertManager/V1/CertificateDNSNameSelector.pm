package IO::K8s::CertManager::V1::CertificateDNSNameSelector;
# ABSTRACT: Selector selects a set of DNSNames on the Certificate resource that should be solved using this challenge solver.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s dnsNames    => [Str];
k8s dnsZones    => [Str];
k8s matchLabels => { Str => 1 };

=attr dnsNames

List of DNSNames that this solver will be used to solve.
If specified and a match is found, a dnsNames selector will take
precedence over a dnsZones selector.
If multiple solvers match with the same dnsNames value, the solver
with the most matching labels in matchLabels will be selected.
If neither has more matches, the solver defined earlier in the list
will be selected.

=cut

=attr dnsZones

List of DNSZones that this solver will be used to solve.
The most specific DNS zone match specified here will take precedence
over other DNS zone matches, so a solver specifying sys.example.com
will be selected over one specifying example.com for the domain
www.sys.example.com.
If multiple solvers match with the same dnsZones value, the solver
with the most matching labels in matchLabels will be selected.
If neither has more matches, the solver defined earlier in the list
will be selected.

=cut

=attr matchLabels

A label selector that is used to refine the set of certificate's that
this challenge solver will apply to.

=cut

1;
