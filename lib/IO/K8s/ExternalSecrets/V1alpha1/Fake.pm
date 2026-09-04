package IO::K8s::ExternalSecrets::V1alpha1::Fake;
# ABSTRACT: Fake generator is used for testing. It lets you define a static set of credentials that is always returned.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'generators.external-secrets.io/v1alpha1',
    resource_plural => 'fakes';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::ExternalSecrets::V1alpha1::FakeSpec';

=attr spec

FakeSpec contains the static data.

=cut

1;
