package IO::K8s::ExternalSecrets::V1::AkeylessAuth;
# ABSTRACT: Auth configures how the operator authenticates with Akeyless.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s kubernetesAuth    => '+IO::K8s::ExternalSecrets::V1::AkeylessKubernetesAuth';
k8s secretRef         => '+IO::K8s::ExternalSecrets::V1::AkeylessAuthSecretRef';
k8s serviceAccountRef => '+IO::K8s::ExternalSecrets::V1::ServiceAccountSelector';

=attr kubernetesAuth

Kubernetes authenticates with Akeyless by passing the ServiceAccount
token stored in the named Secret resource.

=cut

=attr secretRef

Reference to a Secret that contains the details
to authenticate with Akeyless.

=cut

=attr serviceAccountRef

ServiceAccountRef specifies a Kubernetes ServiceAccount used for azure_ad
authentication on AKS Workload Identity. The operator obtains a federated
identity token from this ServiceAccount via the TokenRequest API instead
of using the ESO controller pod identity. Ignored for other access types.

=cut

1;
