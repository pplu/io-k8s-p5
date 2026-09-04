package IO::K8s::ExternalSecrets::V1::DopplerAuthSecretRef;
# ABSTRACT: SecretRef authenticates using a Doppler service token stored in a Kubernetes Secret.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s dopplerToken => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr dopplerToken

The DopplerToken is used for authentication.
See https://docs.doppler.com/reference/api#authentication for auth token types.
The Key attribute defaults to dopplerToken if not specified.

=cut

1;
