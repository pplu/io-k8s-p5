package IO::K8s::ExternalSecrets::V1::FetchingPolicy;
# ABSTRACT: FetchingPolicy configures the provider to interpret the `data.secretKey.remoteRef.key` field in ExternalSecret as secret ID or secret name
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s byID   => { Str => 1 };
k8s byName => '+IO::K8s::ExternalSecrets::V1::ByName';

=attr byID

ByID configures the provider to interpret the `data.secretKey.remoteRef.key` field in ExternalSecret as secret ID.

=cut

=attr byName

ByName configures the provider to interpret the `data.secretKey.remoteRef.key` field in ExternalSecret as secret name.

=cut

1;
