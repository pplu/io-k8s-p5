package IO::K8s::ExternalSecrets::V1::CRDProvider;
# ABSTRACT: CRD configures this store to sync secrets from arbitrary Kubernetes resources, including both custom resources (CRDs) and core API resources.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth      => '+IO::K8s::ExternalSecrets::V1::KubernetesAuth';
k8s authRef   => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s resource  => '+IO::K8s::ExternalSecrets::V1::CRDProviderResource', { required => 'schema' };
k8s server    => '+IO::K8s::ExternalSecrets::V1::KubernetesServer';
k8s whitelist => '+IO::K8s::ExternalSecrets::V1::CRDProviderWhitelist';

=attr auth

Auth configures authentication to the Kubernetes API, same as the
Kubernetes provider. Required when Server.URL is set (unless using AuthRef).

=cut

=attr authRef

AuthRef references a Secret containing a kubeconfig. Same semantics as the
Kubernetes provider.

=cut

=attr resource

Resource identifies the CRD by its API group, version and kind.

=cut

=attr server

Server configures the Kubernetes API address and TLS trust, same as the
Kubernetes provider. When omitted, the URL defaults to the in-cluster API.

=cut

=attr whitelist

Whitelist optionally restricts which object names and requested properties
are allowed to be read.

=cut

1;
