package IO::K8s::ExternalSecrets::V1::CloudruSMProvider;
# ABSTRACT: CloudruSM configures this store to sync secrets using the Cloud.ru Secret Manager provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth      => '+IO::K8s::ExternalSecrets::V1::CSMAuth', { required => 'schema' };
k8s projectID => Str;

=attr auth

CSMAuth contains a secretRef for credentials.

=cut

=attr projectID

ProjectID is the project, which the secrets are stored in.

=cut

1;
