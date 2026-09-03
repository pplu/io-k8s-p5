package IO::K8s::Cilium::V2alpha1::GRPCWebTranslationConfig;
# ABSTRACT: GRPCWebTranslation controls Envoy's gRPC-web to gRPC request translation.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s enabled => Bool, { default => 1 };

=attr enabled

Enabled controls Envoy's gRPC-web to gRPC request translation.

=cut

1;
