package IO::K8s::Api::Core::V1::PodOS;
# ABSTRACT: PodOS defines the OS parameters of a pod.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

Name is the name of the operating system. The currently supported values are linux and windows. Additional value may be defined in future and can be one of: https://github.com/opencontainers/runtime-spec/blob/master/config.md#platform-specific-configuration Clients should expect to handle additional values and treat unrecognized values in this field as os: null

=cut

1;
