package IO::K8s::ExternalSecrets::V1::ExternalSecretMetadata;
# ABSTRACT: The metadata of the external secrets to be created
our $VERSION = '1.112';
use IO::K8s::Resource;

k8s annotations => HashRef[Str];
k8s labels      => HashRef[Str];

=attr annotations

No description in the upstream schema.

=cut

=attr labels

No description in the upstream schema.

=cut

1;
