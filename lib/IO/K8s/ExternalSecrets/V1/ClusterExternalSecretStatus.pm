package IO::K8s::ExternalSecrets::V1::ClusterExternalSecretStatus;
# ABSTRACT: ClusterExternalSecretStatus defines the observed state of ClusterExternalSecret.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conditions            => ['+IO::K8s::ExternalSecrets::V1::ClusterExternalSecretStatusCondition'];
k8s externalSecretName    => Str;
k8s failedNamespaces      => ['+IO::K8s::ExternalSecrets::V1::ClusterExternalSecretNamespaceFailure'];
k8s provisionedNamespaces => [Str];

=attr conditions

No description in the upstream schema.

=cut

=attr externalSecretName

ExternalSecretName is the name of the ExternalSecrets created by the ClusterExternalSecret

=cut

=attr failedNamespaces

Failed namespaces are the namespaces that failed to apply an ExternalSecret

=cut

=attr provisionedNamespaces

ProvisionedNamespaces are the namespaces where the ClusterExternalSecret has secrets

=cut

1;
