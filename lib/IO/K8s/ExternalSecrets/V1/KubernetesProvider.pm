package IO::K8s::ExternalSecrets::V1::KubernetesProvider;
# ABSTRACT: Kubernetes configures this store to sync secrets using a Kubernetes cluster provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth            => '+IO::K8s::ExternalSecrets::V1::KubernetesAuth';
k8s authRef         => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s remoteNamespace => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?$/, default => 'default' };
k8s server          => '+IO::K8s::ExternalSecrets::V1::KubernetesServer';

=attr auth

Auth configures how secret-manager authenticates with a Kubernetes instance.

=cut

=attr authRef

A reference to a secret that contains the auth information.

=cut

=attr remoteNamespace

Remote namespace to fetch the secrets from

=cut

=attr server

configures the Kubernetes server Address.

=cut

1;
