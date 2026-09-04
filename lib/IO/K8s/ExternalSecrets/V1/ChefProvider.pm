package IO::K8s::ExternalSecrets::V1::ChefProvider;
# ABSTRACT: Chef configures this store to sync secrets with chef server
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth      => '+IO::K8s::ExternalSecrets::V1::ChefAuth', { required => 'schema' };
k8s serverUrl => Str, { required => 'schema' };
k8s username  => Str, { required => 'schema' };

=attr auth

Auth defines the information necessary to authenticate against chef Server

=cut

=attr serverUrl

ServerURL is the chef server URL used to connect to. If using orgs you should include your org in the url and terminate the url with a "/"

=cut

=attr username

UserName should be the user ID on the chef server

=cut

1;
