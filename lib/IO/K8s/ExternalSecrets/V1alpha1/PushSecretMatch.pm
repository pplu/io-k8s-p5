package IO::K8s::ExternalSecrets::V1alpha1::PushSecretMatch;
# ABSTRACT: Match a given Secret Key to be pushed to the provider.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s remoteRef => '+IO::K8s::ExternalSecrets::V1alpha1::PushSecretRemoteRef', { required => 'schema' };
k8s secretKey => Str;

=attr remoteRef

Remote Refs to push to providers.

=cut

=attr secretKey

Secret Key to be pushed

=cut

1;
