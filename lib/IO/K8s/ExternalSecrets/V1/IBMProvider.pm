package IO::K8s::ExternalSecrets::V1::IBMProvider;
# ABSTRACT: IBM configures this store to sync secrets using IBM Cloud provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth       => '+IO::K8s::ExternalSecrets::V1::IBMAuth', { required => 'schema' };
k8s serviceUrl => Str;

=attr auth

Auth configures how secret-manager authenticates with the IBM secrets manager.

=cut

=attr serviceUrl

ServiceURL is the Endpoint URL that is specific to the Secrets Manager service instance

=cut

1;
