package IO::K8s::Api::Core::V1::GitRepoVolumeSource;
# ABSTRACT: Represents a volume that is populated with the contents of a git repository. Git repo volumes do not support ownership management. Git repo volumes support SELinux relabeling. DEPRECATED: GitRepo is deprecated. To provision a container with a git repo, mount an EmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir into the Pod's container.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s directory => Str;

=attr directory

directory is the target directory name. Must not contain or start with '..'.  If '.' is supplied, the volume directory will be the git repository.  Otherwise, if specified, the volume will contain the git repository in the subdirectory with the given name.

=cut

k8s repository => Str, 'required';

=attr repository

repository is the URL

=cut

k8s revision => Str;

=attr revision

revision is the commit hash for the specified revision.

=cut

1;
