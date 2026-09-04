package IO::K8s::ExternalSecrets::V1::SecretStore;
# ABSTRACT: SecretStore represents a secure external location for storing secrets, which can be referenced as part of `storeRef` fields.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'external-secrets.io/v1',
    resource_plural => 'secretstores';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::ExternalSecrets::V1::SecretStoreSpec';
k8s status => '+IO::K8s::ExternalSecrets::V1::SecretStoreStatus';

=attr spec

SecretStoreSpec defines the desired state of SecretStore.

=cut

=attr status

SecretStoreStatus defines the observed state of the SecretStore.

=cut

1;
