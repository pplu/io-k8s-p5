package IO::K8s::Api::Core::V1::LinuxContainerUser;
# ABSTRACT: LinuxContainerUser represents user identity information in Linux containers
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s gid => Int, 'required';

=attr gid

GID is the primary gid initially attached to the first process in the container

=cut

k8s supplementalGroups => [Int];

=attr supplementalGroups

SupplementalGroups are the supplemental groups initially attached to the first process in the container

=cut

k8s uid => Int, 'required';

=attr uid

UID is the primary uid initially attached to the first process in the container

=cut

1;
