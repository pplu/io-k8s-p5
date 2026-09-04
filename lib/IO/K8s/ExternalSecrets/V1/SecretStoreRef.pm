package IO::K8s::ExternalSecrets::V1::SecretStoreRef;
# ABSTRACT: SecretStoreRef defines which SecretStore to fetch the ExternalSecret data.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s kind => Str, { enum => [qw(SecretStore ClusterSecretStore)] };
k8s name => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };

=attr kind

Kind of the SecretStore resource (SecretStore or ClusterSecretStore)
Defaults to `SecretStore`

=cut

=attr name

Name of the SecretStore resource

=cut

1;
