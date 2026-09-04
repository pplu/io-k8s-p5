package IO::K8s::ExternalSecrets::V1::OnePasswordProvider;
# ABSTRACT: OnePassword configures this store to sync secrets using the 1Password Cloud provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth        => '+IO::K8s::ExternalSecrets::V1::OnePasswordAuth', { required => 'schema' };
k8s connectHost => Str, { required => 'schema' };
k8s vaults      => { Str => 1 }, { required => 'schema' };

=attr auth

Auth defines the information necessary to authenticate against OnePassword Connect Server

=cut

=attr connectHost

ConnectHost defines the OnePassword Connect Server to connect to

=cut

=attr vaults

Vaults defines which OnePassword vaults to search in which order

=cut

1;
