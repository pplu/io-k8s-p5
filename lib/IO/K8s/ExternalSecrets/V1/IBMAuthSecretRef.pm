package IO::K8s::ExternalSecrets::V1::IBMAuthSecretRef;
# ABSTRACT: IBMAuthSecretRef contains the secret reference for IBM Cloud API key authentication.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s iamEndpoint           => Str;
k8s secretApiKeySecretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';

=attr iamEndpoint

The IAM endpoint used to obain a token

=cut

=attr secretApiKeySecretRef

The SecretAccessKey is used for authentication

=cut

1;
