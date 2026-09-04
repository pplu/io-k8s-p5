package IO::K8s::ExternalSecrets::V1::ConjurAPIKey;
# ABSTRACT: Authenticates with Conjur using an API key.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s account   => Str, { required => 'schema' };
k8s apiKeyRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s userRef   => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr account

Account is the Conjur organization account name.

=cut

=attr apiKeyRef

A reference to a specific 'key' containing the Conjur API key
within a Secret resource. In some instances, `key` is a required field.

=cut

=attr userRef

A reference to a specific 'key' containing the Conjur username
within a Secret resource. In some instances, `key` is a required field.

=cut

1;
