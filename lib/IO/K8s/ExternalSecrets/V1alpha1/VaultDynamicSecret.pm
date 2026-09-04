package IO::K8s::ExternalSecrets::V1alpha1::VaultDynamicSecret;
# ABSTRACT: VaultDynamicSecret represents a generator that can create dynamic secrets from HashiCorp Vault.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'generators.external-secrets.io/v1alpha1',
    resource_plural => 'vaultdynamicsecrets';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::ExternalSecrets::V1alpha1::VaultDynamicSecretSpec';

=attr spec

VaultDynamicSecretSpec defines the desired spec of VaultDynamicSecret.

=cut

1;
