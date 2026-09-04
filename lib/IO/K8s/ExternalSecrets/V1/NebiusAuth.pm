package IO::K8s::ExternalSecrets::V1::NebiusAuth;
# ABSTRACT: Auth defines parameters to authenticate in MysteryBox
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s serviceAccountCredsSecretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s tokenSecretRef               => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s workloadIdentity             => '+IO::K8s::ExternalSecrets::V1::NebiusWorkloadIdentity';

=attr serviceAccountCredsSecretRef

ServiceAccountCreds references a Kubernetes Secret key that contains a JSON
document with service account credentials used to get an IAM token.

Expected JSON structure:
{
  "subject-credentials": {
    "alg": "RS256",
    "private-key": "-----BEGIN PRIVATE KEY-----\n<private-key>\n-----END PRIVATE KEY-----\n",
    "kid": "<public-key-id>",
    "iss": "<issuer-service-account-id>",
    "sub": "<subject-service-account-id>"
  }
}

=cut

=attr tokenSecretRef

Token authenticates with Nebius Mysterybox by presenting a token.

=cut

=attr workloadIdentity

WorkloadIdentity defines configuration for workload identity authentication to Nebius IAM.

=cut

1;
