package IO::K8s::Api::Core::V1::Capabilities;
# ABSTRACT: Adds and removes POSIX capabilities from running containers.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s add => [Str];

=attr add

Added capabilities

=cut

k8s drop => [Str];

=attr drop

Removed capabilities

=cut

1;
