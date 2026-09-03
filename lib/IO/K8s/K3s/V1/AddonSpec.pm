package IO::K8s::K3s::V1::AddonSpec;
# ABSTRACT: AddonSpec
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s checksum => Str;
k8s source   => Str;

=attr checksum

Checksum is the SHA256 checksum of the most recently successfully applied manifest file.

=cut

=attr source

Source is the Path on disk to the manifest file that this Addon tracks.

=cut

1;
