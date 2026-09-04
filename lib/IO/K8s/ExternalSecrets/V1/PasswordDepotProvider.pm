package IO::K8s::ExternalSecrets::V1::PasswordDepotProvider;
# ABSTRACT: PasswordDepotProvider configures a store to sync secrets with a Password Depot instance.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth     => '+IO::K8s::ExternalSecrets::V1::PasswordDepotAuth', { required => 'schema' };
k8s database => Str, { required => 'schema' };
k8s host     => Str, { required => 'schema' };

=attr auth

Auth configures how secret-manager authenticates with a Password Depot instance.

=cut

=attr database

Database to use as source

=cut

=attr host

URL configures the Password Depot instance URL.

=cut

1;
