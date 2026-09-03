package IO::K8s::Cilium::V2alpha1::EnvoyConfig;
# ABSTRACT: Envoy specifies proxy configuration options.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s serverHeaderTransformation => Str, { enum => [qw(OVERWRITE APPEND_IF_ABSENT PASS_THROUGH)], default => 'OVERWRITE' };

=attr serverHeaderTransformation

ServerHeaderTransformation controls the HTTP "Server" response header.
Defaults to OVERWRITE.

=cut

1;
