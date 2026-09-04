package IO::K8s::ExternalSecrets::V1alpha1::ACRManagedIdentity;
# ABSTRACT: ManagedIdentity uses Azure Managed Identity to authenticate with Azure.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s identityId => Str;

=attr identityId

If multiple Managed Identity is assigned to the pod, you can select the one to be used

=cut

1;
