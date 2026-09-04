package IO::K8s::ExternalSecrets::V1alpha1::BeyondtrustWorkloadCredentialsDynamicSecret;
# ABSTRACT: BeyondtrustWorkloadCredentialsDynamicSecret represents a generator that requests dynamic credentials from BeyondTrust Workload Credentials.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'generators.external-secrets.io/v1alpha1',
    resource_plural => 'beyondtrustworkloadcredentialsdynamicsecrets';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::ExternalSecrets::V1alpha1::BeyondtrustWorkloadCredentialsDynamicSecretSpec';

=attr spec

BeyondtrustWorkloadCredentialsDynamicSecretSpec defines the desired spec for BeyondtrustWorkloadCredentials dynamic generator.
This generator enables obtaining temporary, short-lived credentials from BeyondTrust Workload Credentials.
For more information, see: https://docs.beyondtrust.com/bt-docs/docs/secrets-api

=cut

1;
