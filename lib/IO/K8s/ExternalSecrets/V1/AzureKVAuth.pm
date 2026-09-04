package IO::K8s::ExternalSecrets::V1::AzureKVAuth;
# ABSTRACT: Auth configures how the operator authenticates with Azure.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s clientCertificate => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s clientId          => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s clientSecret      => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s tenantId          => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';

=attr clientCertificate

The Azure ClientCertificate of the service principle used for authentication.

=cut

=attr clientId

The Azure clientId of the service principle or managed identity used for authentication.

=cut

=attr clientSecret

The Azure ClientSecret of the service principle used for authentication.

=cut

=attr tenantId

The Azure tenantId of the managed identity used for authentication.

=cut

1;
