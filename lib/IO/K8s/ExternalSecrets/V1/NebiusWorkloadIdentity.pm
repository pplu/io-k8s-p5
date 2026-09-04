package IO::K8s::ExternalSecrets::V1::NebiusWorkloadIdentity;
# ABSTRACT: WorkloadIdentity defines configuration for workload identity authentication to Nebius IAM.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s iamServiceAccountID => Str, { required => 'schema', pattern => qr/^serviceaccount-[a-z][a-z0-9]{2}/ };
k8s serviceAccountRef   => '+IO::K8s::ExternalSecrets::V1::ServiceAccountSelector', { required => 'schema' };

=attr iamServiceAccountID

IAMServiceAccountID is the Nebius IAM service account identifier that the
federated Kubernetes service account should impersonate during token exchange.

=cut

=attr serviceAccountRef

ServiceAccountRef references a Kubernetes ServiceAccount used to request a
temporary JWT via the TokenRequest API. The JWT is then exchanged for a
Nebius IAM token using workload federation.

=cut

1;
