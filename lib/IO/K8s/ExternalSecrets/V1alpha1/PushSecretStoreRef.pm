package IO::K8s::ExternalSecrets::V1alpha1::PushSecretStoreRef;
# ABSTRACT: StoreRef specifies which SecretStore to push to.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s kind          => Str, { enum => [qw(SecretStore ClusterSecretStore)], default => 'SecretStore' };
k8s labelSelector => 'Meta::V1::LabelSelector';
k8s name          => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };

=attr kind

Kind of the SecretStore resource (SecretStore or ClusterSecretStore)

=cut

=attr labelSelector

Optionally, sync to secret stores with label selector

=cut

=attr name

Optionally, sync to the SecretStore of the given name

=cut

1;
