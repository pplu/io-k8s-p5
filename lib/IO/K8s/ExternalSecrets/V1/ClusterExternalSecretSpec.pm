package IO::K8s::ExternalSecrets::V1::ClusterExternalSecretSpec;
# ABSTRACT: ClusterExternalSecretSpec defines the desired state of ClusterExternalSecret.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s externalSecretMetadata => '+IO::K8s::ExternalSecrets::V1::ExternalSecretMetadata';
k8s externalSecretName     => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };
k8s externalSecretSpec     => '+IO::K8s::ExternalSecrets::V1::ExternalSecretSpec', { required => 'schema' };
k8s namespaceSelector      => 'Meta::V1::LabelSelector';
k8s namespaceSelectors     => ['Meta::V1::LabelSelector'];
k8s namespaces             => [Str], { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?$/ };
k8s refreshTime            => Str;

=attr externalSecretMetadata

The metadata of the external secrets to be created

=cut

=attr externalSecretName

The name of the external secrets to be created.
Defaults to the name of the ClusterExternalSecret

=cut

=attr externalSecretSpec

The spec for the ExternalSecrets to be created

=cut

=attr namespaceSelector

The labels to select by to find the Namespaces to create the ExternalSecrets in.

Deprecated: Use NamespaceSelectors instead.

=cut

=attr namespaceSelectors

A list of labels to select by to find the Namespaces to create the ExternalSecrets in. The selectors are ORed.

=cut

=attr namespaces

Choose namespaces by name. This field is ORed with anything that NamespaceSelectors ends up choosing.

Deprecated: Use NamespaceSelectors instead.

=cut

=attr refreshTime

The time in which the controller should reconcile its objects and recheck namespaces for labels.

=cut

1;
