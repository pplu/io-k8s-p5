package IO::K8s::ExternalSecrets::V1::GCPSMAuth;
# ABSTRACT: Auth defines the information necessary to authenticate against GCP
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretRef                  => '+IO::K8s::ExternalSecrets::V1::GCPSMAuthSecretRef';
k8s workloadIdentity           => '+IO::K8s::ExternalSecrets::V1::GCPWorkloadIdentity';
k8s workloadIdentityFederation => '+IO::K8s::ExternalSecrets::V1::GCPWorkloadIdentityFederation';

=attr secretRef

GCPSMAuthSecretRef contains the secret references for GCP Secret Manager authentication.

=cut

=attr workloadIdentity

GCPWorkloadIdentity defines configuration for workload identity authentication to GCP.

=cut

=attr workloadIdentityFederation

GCPWorkloadIdentityFederation holds the configurations required for generating federated access tokens.

=cut

1;
