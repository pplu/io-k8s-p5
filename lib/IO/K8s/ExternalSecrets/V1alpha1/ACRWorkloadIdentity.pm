package IO::K8s::ExternalSecrets::V1alpha1::ACRWorkloadIdentity;
# ABSTRACT: WorkloadIdentity uses Azure Workload Identity to authenticate with Azure.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s serviceAccountRef => '+IO::K8s::ExternalSecrets::V1::ServiceAccountSelector';

=attr serviceAccountRef

ServiceAccountRef specified the service account
that should be used when authenticating with WorkloadIdentity.

=cut

1;
