package IO::K8s::ExternalSecrets::V1::ClusterSecretStoreCondition;
# ABSTRACT: ClusterSecretStoreCondition describes a condition by which to choose namespaces to process ExternalSecrets in for a ClusterSecretStore instance.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s namespaceRegexes  => [Str];
k8s namespaceSelector => 'Meta::V1::LabelSelector';
k8s namespaces        => [Str], { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?$/ };

=attr namespaceRegexes

Choose namespaces by using regex matching

=cut

=attr namespaceSelector

Choose namespace using a labelSelector

=cut

=attr namespaces

Choose namespaces by name

=cut

1;
