package IO::K8s::ExternalSecrets::V1alpha1::MFA;
# ABSTRACT: MFA generates a new TOTP token that is compliant with RFC 6238.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'generators.external-secrets.io/v1alpha1',
    resource_plural => 'mfas';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::ExternalSecrets::V1alpha1::MFASpec';

=attr spec

MFASpec controls the behavior of the mfa generator.

=cut

1;
