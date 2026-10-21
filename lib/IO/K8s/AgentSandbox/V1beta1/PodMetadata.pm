package IO::K8s::AgentSandbox::V1beta1::PodMetadata;
# ABSTRACT: PodMetadata
our $VERSION = '1.112';
use IO::K8s::Resource;

k8s annotations => HashRef[Str];
k8s labels      => HashRef[Str];

=attr annotations

No description in the upstream schema.

=cut

=attr labels

No description in the upstream schema.

=cut

1;
