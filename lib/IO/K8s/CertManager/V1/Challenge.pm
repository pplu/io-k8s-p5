package IO::K8s::CertManager::V1::Challenge;
# ABSTRACT: Challenge is a type to represent a Challenge request with an ACME server
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'acme.cert-manager.io/v1',
    resource_plural => 'challenges';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::CertManager::V1::ChallengeSpec', { required => 'schema' };
k8s status => '+IO::K8s::CertManager::V1::ChallengeStatus';

=attr spec

No description in the upstream schema.

=cut

=attr status

No description in the upstream schema.

=cut

1;
