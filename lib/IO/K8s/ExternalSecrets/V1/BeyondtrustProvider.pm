package IO::K8s::ExternalSecrets::V1::BeyondtrustProvider;
# ABSTRACT: Beyondtrust configures this store to sync secrets using Password Safe provider.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth   => '+IO::K8s::ExternalSecrets::V1::BeyondtrustAuth', { required => 'schema' };
k8s server => '+IO::K8s::ExternalSecrets::V1::BeyondtrustServer', { required => 'schema' };

=attr auth

Auth configures how the operator authenticates with Beyondtrust.

=cut

=attr server

Auth configures how API server works.

=cut

1;
