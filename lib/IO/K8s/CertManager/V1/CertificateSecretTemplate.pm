package IO::K8s::CertManager::V1::CertificateSecretTemplate;
# ABSTRACT: Defines annotations and labels to be copied to the Certificate's Secret.
our $VERSION = '1.112';
use IO::K8s::Resource;

k8s annotations => HashRef[Str];
k8s labels      => HashRef[Str];

=attr annotations

Annotations is a key value map to be copied to the target Kubernetes Secret.

=cut

=attr labels

Labels is a key value map to be copied to the target Kubernetes Secret.

=cut

1;
