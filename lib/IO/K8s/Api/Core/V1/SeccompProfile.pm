package IO::K8s::Api::Core::V1::SeccompProfile;
# ABSTRACT: SeccompProfile defines a pod/container's seccomp profile settings. Only one profile source may be set.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s localhostProfile => Str;

=attr localhostProfile

localhostProfile indicates a profile defined in a file on the node should be used. The profile must be preconfigured on the node to work. Must be a descending path, relative to the kubelet's configured seccomp profile location. Must be set if type is "Localhost". Must NOT be set for any other type.

=cut

k8s type => Str, 'required';

=attr type

type indicates which kind of seccomp profile will be applied. Valid options are:

Localhost - a profile defined in a file on the node should be used. RuntimeDefault - the container runtime default profile should be used. Unconfined - no profile should be applied.

=cut

1;
