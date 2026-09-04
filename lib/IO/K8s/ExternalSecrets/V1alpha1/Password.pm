package IO::K8s::ExternalSecrets::V1alpha1::Password;
# ABSTRACT: Password generates a random password based on the configuration parameters in spec.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'generators.external-secrets.io/v1alpha1',
    resource_plural => 'passwords';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::ExternalSecrets::V1alpha1::PasswordSpec';

=attr spec

PasswordSpec controls the behavior of the password generator.

=cut

1;
