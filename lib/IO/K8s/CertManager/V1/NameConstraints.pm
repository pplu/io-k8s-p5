package IO::K8s::CertManager::V1::NameConstraints;
# ABSTRACT: x.509 certificate NameConstraint extension which MUST NOT be used in a non-CA certificate.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s critical  => Bool;
k8s excluded  => '+IO::K8s::CertManager::V1::NameConstraintItem';
k8s permitted => '+IO::K8s::CertManager::V1::NameConstraintItem';

=attr critical

if true then the name constraints are marked critical.

=cut

=attr excluded

Excluded contains the constraints which must be disallowed. Any name matching a
restriction in the excluded field is invalid regardless
of information appearing in the permitted

=cut

=attr permitted

Permitted contains the constraints in which the names must be located.

=cut

1;
