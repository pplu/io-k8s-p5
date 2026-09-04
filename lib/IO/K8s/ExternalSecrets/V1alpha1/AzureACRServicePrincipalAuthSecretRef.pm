package IO::K8s::ExternalSecrets::V1alpha1::AzureACRServicePrincipalAuthSecretRef;
# ABSTRACT: AzureACRServicePrincipalAuthSecretRef defines the secret references for Azure Service Principal authentication.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s clientId     => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s clientSecret => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';

=attr clientId

The Azure clientId of the service principle used for authentication.

=cut

=attr clientSecret

The Azure ClientSecret of the service principle used for authentication.

=cut

1;
