package IO::K8s::Api::Core::V1::DownwardAPIProjection;
# ABSTRACT: Represents downward API info for projecting into a projected volume. Note that this is identical to a downwardAPI volume source without the default mode.

use IO::K8s::Resource;

k8s items => ['Core::V1::DownwardAPIVolumeFile'];

=attr items

Items is a list of DownwardAPIVolume file

=cut

1;
