package IO::K8s::ExternalSecrets::V1::ExternalSecret;
# ABSTRACT: ExternalSecret is the Schema for the external-secrets API.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'external-secrets.io/v1',
    resource_plural => 'externalsecrets';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::ExternalSecrets::V1::ExternalSecretSpec';
k8s status => '+IO::K8s::ExternalSecrets::V1::ExternalSecretStatus';

=attr spec

ExternalSecretSpec defines the desired state of ExternalSecret.

=cut

=attr status

ExternalSecretStatus defines the observed state of ExternalSecret.

=cut

1;
