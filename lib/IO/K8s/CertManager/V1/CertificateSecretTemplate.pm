package IO::K8s::CertManager::V1::CertificateSecretTemplate;
# ABSTRACT: Defines annotations and labels to be copied to the Certificate's Secret.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s annotations => { Str => 1 };
k8s labels      => { Str => 1 };

=attr annotations

Annotations is a key value map to be copied to the target Kubernetes Secret.

=cut

=attr labels

Labels is a key value map to be copied to the target Kubernetes Secret.

=cut

1;
