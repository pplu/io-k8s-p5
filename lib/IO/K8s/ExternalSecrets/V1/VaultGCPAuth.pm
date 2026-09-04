package IO::K8s::ExternalSecrets::V1::VaultGCPAuth;
# ABSTRACT: Gcp authenticates with Vault using Google Cloud Platform authentication method GCP authentication method
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s location          => Str;
k8s path              => Str, { default => 'gcp' };
k8s projectID         => Str;
k8s role              => Str, { required => 'schema' };
k8s secretRef         => '+IO::K8s::ExternalSecrets::V1::GCPSMAuthSecretRef';
k8s serviceAccountRef => '+IO::K8s::ExternalSecrets::V1::ServiceAccountSelector';
k8s workloadIdentity  => '+IO::K8s::ExternalSecrets::V1::GCPWorkloadIdentity';

=attr location

Location optionally defines a location/region for the secret

=cut

=attr path

Path where the GCP auth method is enabled in Vault, e.g: "gcp"

=cut

=attr projectID

Project ID of the Google Cloud Platform project

=cut

=attr role

Vault Role. In Vault, a role describes an identity with a set of permissions, groups, or policies you want to attach to a user of the secrets engine.

=cut

=attr secretRef

Specify credentials in a Secret object

=cut

=attr serviceAccountRef

ServiceAccountRef to a service account for impersonation

=cut

=attr workloadIdentity

Specify a service account with Workload Identity

=cut

1;
