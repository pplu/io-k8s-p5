package IO::K8s::ExternalSecrets::V1::KubernetesServer;
# ABSTRACT: configures the Kubernetes server Address.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s caBundle   => Str;
k8s caProvider => '+IO::K8s::ExternalSecrets::V1::CAProvider';
k8s url        => Str, { default => 'kubernetes.default' };

=attr caBundle

CABundle is a base64-encoded CA certificate

=cut

=attr caProvider

see: https://external-secrets.io/latest/spec/#external-secrets.io/v1alpha1.CAProvider

=cut

=attr url

configures the Kubernetes server Address.

=cut

1;
