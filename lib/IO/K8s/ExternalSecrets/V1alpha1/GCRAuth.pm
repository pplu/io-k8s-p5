package IO::K8s::ExternalSecrets::V1alpha1::GCRAuth;
# ABSTRACT: Auth defines the means for authenticating with GCP
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretRef                  => '+IO::K8s::ExternalSecrets::V1::GCPSMAuthSecretRef';
k8s workloadIdentity           => '+IO::K8s::ExternalSecrets::V1alpha1::GCRWorkloadIdentity';
k8s workloadIdentityFederation => '+IO::K8s::ExternalSecrets::V1::GCPWorkloadIdentityFederation';

=attr secretRef

GCPSMAuthSecretRef defines the reference to a secret containing Google Cloud Platform credentials.

=cut

=attr workloadIdentity

GCPWorkloadIdentity defines the configuration for using GCP Workload Identity authentication.

=cut

=attr workloadIdentityFederation

GCPWorkloadIdentityFederation holds the configurations required for generating federated access tokens.

=cut

1;
