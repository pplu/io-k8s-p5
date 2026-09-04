package IO::K8s::ExternalSecrets::V1::BeyondtrustAuth;
# ABSTRACT: Auth configures how the operator authenticates with Beyondtrust.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiKey         => '+IO::K8s::ExternalSecrets::V1::BeyondTrustProviderSecretRef';
k8s certificate    => '+IO::K8s::ExternalSecrets::V1::BeyondTrustProviderSecretRef';
k8s certificateKey => '+IO::K8s::ExternalSecrets::V1::BeyondTrustProviderSecretRef';
k8s clientId       => '+IO::K8s::ExternalSecrets::V1::BeyondTrustProviderSecretRef';
k8s clientSecret   => '+IO::K8s::ExternalSecrets::V1::BeyondTrustProviderSecretRef';

=attr apiKey

APIKey If not provided then ClientID/ClientSecret become required.

=cut

=attr certificate

Certificate (cert.pem) for use when authenticating with an OAuth client Id using a Client Certificate.

=cut

=attr certificateKey

Certificate private key (key.pem). For use when authenticating with an OAuth client Id

=cut

=attr clientId

ClientID is the API OAuth Client ID.

=cut

=attr clientSecret

ClientSecret is the API OAuth Client Secret.

=cut

1;
