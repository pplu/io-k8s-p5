package IO::K8s::Api::Core::V1::SELinuxOptions;
# ABSTRACT: SELinuxOptions are the labels to be applied to the container

use IO::K8s::Resource;

k8s level => Str;

=attr level

Level is SELinux level label that applies to the container.

=cut

k8s role => Str;

=attr role

Role is a SELinux role label that applies to the container.

=cut

k8s type => Str;

=attr type

Type is a SELinux type label that applies to the container.

=cut

k8s user => Str;

=attr user

User is a SELinux user label that applies to the container.

=cut

1;
