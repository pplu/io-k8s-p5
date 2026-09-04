package IO::K8s::ExternalSecrets::V1::PreviderProvider;
# ABSTRACT: Previder configures this store to sync secrets using the Previder provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth    => '+IO::K8s::ExternalSecrets::V1::PreviderAuth', { required => 'schema' };
k8s baseUri => Str;

=attr auth

PreviderAuth contains a secretRef for credentials.

=cut

=attr baseUri

No description in the upstream schema.

=cut

1;
