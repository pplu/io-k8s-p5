package IO::K8s::ExternalSecrets::V1alpha1::STSSessionToken;
# ABSTRACT: STSSessionToken uses the GetSessionToken API to retrieve an authorization token.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'generators.external-secrets.io/v1alpha1',
    resource_plural => 'stssessiontokens';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::ExternalSecrets::V1alpha1::STSSessionTokenSpec';

=attr spec

STSSessionTokenSpec defines the desired state to generate an AWS STS session token.

=cut

1;
