package IO::K8s::ExternalSecrets::V1::SecretStoreRetrySettings;
# ABSTRACT: Used to configure HTTP retries on failures.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s maxRetries    => Int;
k8s retryInterval => Str;

=attr maxRetries

No description in the upstream schema.

=cut

=attr retryInterval

No description in the upstream schema.

=cut

1;
