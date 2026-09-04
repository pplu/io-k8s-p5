package IO::K8s::ExternalSecrets::V1alpha1::UUID;
# ABSTRACT: UUID generates a version 1 UUID (e56657e3-764f-11ef-a397-65231a88c216).
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'generators.external-secrets.io/v1alpha1',
    resource_plural => 'uuids';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::ExternalSecrets::V1alpha1::UUIDSpec';

=attr spec

UUIDSpec controls the behavior of the uuid generator.

=cut

1;
