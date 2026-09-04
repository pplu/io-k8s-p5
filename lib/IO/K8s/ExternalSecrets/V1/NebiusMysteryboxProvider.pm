package IO::K8s::ExternalSecrets::V1::NebiusMysteryboxProvider;
# ABSTRACT: NebiusMysterybox configures this store to sync secrets using NebiusMysterybox provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiDomain  => Str, { required => 'schema' };
k8s auth       => '+IO::K8s::ExternalSecrets::V1::NebiusAuth', { required => 'schema' };
k8s caProvider => '+IO::K8s::ExternalSecrets::V1::NebiusCAProvider';

=attr apiDomain

NebiusMysterybox API endpoint

=cut

=attr auth

Auth defines parameters to authenticate in MysteryBox

=cut

=attr caProvider

The provider for the CA bundle to use to validate NebiusMysterybox server certificate.

=cut

1;
