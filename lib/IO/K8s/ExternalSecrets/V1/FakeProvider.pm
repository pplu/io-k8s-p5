package IO::K8s::ExternalSecrets::V1::FakeProvider;
# ABSTRACT: Fake configures a store with static key/value pairs
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s data             => ['+IO::K8s::ExternalSecrets::V1::FakeProviderData'], { required => 'schema' };
k8s validationResult => Int;

=attr data

No description in the upstream schema.

=cut

=attr validationResult

ValidationResult is defined type for the number of validation results.

=cut

1;
