package IO::K8s::ExternalSecrets::V1alpha1::ClusterPushSecretStatus;
# ABSTRACT: ClusterPushSecretStatus contains the status information for the ClusterPushSecret resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conditions            => ['Core::V1::NamespaceCondition'];
k8s failedNamespaces      => ['+IO::K8s::ExternalSecrets::V1alpha1::ClusterPushSecretNamespaceFailure'];
k8s provisionedNamespaces => [Str];
k8s pushSecretName        => Str;

=attr conditions

No description in the upstream schema.

=cut

=attr failedNamespaces

Failed namespaces are the namespaces that failed to apply an PushSecret

=cut

=attr provisionedNamespaces

ProvisionedNamespaces are the namespaces where the ClusterPushSecret has secrets

=cut

=attr pushSecretName

No description in the upstream schema.

=cut

1;
