package IO::K8s::ExternalSecrets::V1alpha1::PushSecretRemoteRef;
# ABSTRACT: Remote Refs to push to providers.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s property  => Str;
k8s remoteKey => Str, { required => 'schema' };

=attr property

Name of the property in the resulting secret

=cut

=attr remoteKey

Name of the resulting provider secret.

=cut

1;
