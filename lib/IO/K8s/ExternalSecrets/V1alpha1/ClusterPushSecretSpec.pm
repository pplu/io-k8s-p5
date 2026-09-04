package IO::K8s::ExternalSecrets::V1alpha1::ClusterPushSecretSpec;
# ABSTRACT: ClusterPushSecretSpec defines the configuration for a ClusterPushSecret resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s namespaceSelectors => ['Meta::V1::LabelSelector'];
k8s pushSecretMetadata => '+IO::K8s::ExternalSecrets::V1alpha1::PushSecretMetadata';
k8s pushSecretName     => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };
k8s pushSecretSpec     => '+IO::K8s::ExternalSecrets::V1alpha1::PushSecretSpec', { required => 'schema' };
k8s refreshTime        => Str;

=attr namespaceSelectors

A list of labels to select by to find the Namespaces to create the ExternalSecrets in. The selectors are ORed.

=cut

=attr pushSecretMetadata

The metadata of the external secrets to be created

=cut

=attr pushSecretName

The name of the push secrets to be created.
Defaults to the name of the ClusterPushSecret

=cut

=attr pushSecretSpec

PushSecretSpec defines what to do with the secrets.

=cut

=attr refreshTime

The time in which the controller should reconcile its objects and recheck namespaces for labels.

=cut

1;
