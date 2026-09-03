package IO::K8s::Cilium::V2::BGPAttributes;
# ABSTRACT: Attributes defines additional attributes to set to the advertised routes.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s communities     => '+IO::K8s::Cilium::V2::BGPCommunities';
k8s localPreference => Int;

=attr communities

Communities sets the community attributes in the route.
If not specified, no community attribute is set.

=cut

=attr localPreference

LocalPreference sets the local preference attribute in the route.
If not specified, no local preference attribute is set.

=cut

1;
