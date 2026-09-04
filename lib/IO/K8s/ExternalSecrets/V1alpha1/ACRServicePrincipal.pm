package IO::K8s::ExternalSecrets::V1alpha1::ACRServicePrincipal;
# ABSTRACT: ServicePrincipal uses Azure Service Principal credentials to authenticate with Azure.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretRef => '+IO::K8s::ExternalSecrets::V1alpha1::AzureACRServicePrincipalAuthSecretRef', { required => 'schema' };

=attr secretRef

AzureACRServicePrincipalAuthSecretRef defines the secret references for Azure Service Principal authentication.
It uses static credentials stored in a Kind=Secret.

=cut

1;
