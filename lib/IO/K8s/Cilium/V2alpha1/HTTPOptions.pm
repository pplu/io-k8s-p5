package IO::K8s::Cilium::V2alpha1::HTTPOptions;
# ABSTRACT: HTTPOptions specifies HTTP connection manager options.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s grpcWebTranslation => '+IO::K8s::Cilium::V2alpha1::GRPCWebTranslationConfig';

=attr grpcWebTranslation

GRPCWebTranslation controls Envoy's gRPC-web to gRPC request translation.

=cut

1;
