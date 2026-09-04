package IO::K8s::ExternalSecrets::V1alpha1::SSHKey;
# ABSTRACT: SSHKey generates SSH key pairs.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'generators.external-secrets.io/v1alpha1',
    resource_plural => 'sshkeys';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::ExternalSecrets::V1alpha1::SSHKeySpec';

=attr spec

SSHKeySpec controls the behavior of the ssh key generator.

=cut

1;
