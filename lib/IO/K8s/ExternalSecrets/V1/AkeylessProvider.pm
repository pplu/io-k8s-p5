package IO::K8s::ExternalSecrets::V1::AkeylessProvider;
# ABSTRACT: Akeyless configures this store to sync secrets using Akeyless Vault provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s akeylessGWApiURL => Str, { required => 'schema' };
k8s authSecretRef    => '+IO::K8s::ExternalSecrets::V1::AkeylessAuth', { required => 'schema' };
k8s caBundle         => Str;
k8s caProvider       => '+IO::K8s::ExternalSecrets::V1::CAProvider';
k8s ignoreCache      => Bool;

=attr akeylessGWApiURL

Akeyless GW API Url from which the secrets to be fetched from.

=cut

=attr authSecretRef

Auth configures how the operator authenticates with Akeyless.

=cut

=attr caBundle

PEM/base64 encoded CA bundle used to validate Akeyless Gateway certificate. Only used
if the AkeylessGWApiURL URL is using HTTPS protocol. If not set the system root certificates
are used to validate the TLS connection.

=cut

=attr caProvider

The provider for the CA bundle to use to validate Akeyless Gateway certificate.

=cut

=attr ignoreCache

IgnoreCache bypasses the Gateway cache for secret reads when true.
Only relevant when akeylessGWApiURL points to an Akeyless Gateway.

=cut

1;
