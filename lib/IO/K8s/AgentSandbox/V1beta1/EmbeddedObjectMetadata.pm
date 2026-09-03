package IO::K8s::AgentSandbox::V1beta1::EmbeddedObjectMetadata;
# ABSTRACT: EmbeddedObjectMetadata
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s annotations => { Str => 1 };
k8s labels      => { Str => 1 };
k8s name        => Str;

=attr annotations

No description in the upstream schema.

=cut

=attr labels

No description in the upstream schema.

=cut

=attr name

No description in the upstream schema.

=cut

1;
