package IO::K8s::Api::Core::V1::GRPCAction;
# ABSTRACT: 
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s mode => Str;

=attr mode

mode specifies the connection mode for the gRPC health probe. Set to "TLS" to use TLS without certificate verification. Set to "Plaintext" to use a plaintext (insecure) connection explicitly. If not specified, the probe uses a plaintext (insecure) connection.

=cut

k8s port => Int, 'required';

=attr port

Port number of the gRPC service. Number must be in the range 1 to 65535.

=cut

k8s service => Str;

=attr service

Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).

If this is not specified, the default behavior is defined by gRPC.

=cut

1;
