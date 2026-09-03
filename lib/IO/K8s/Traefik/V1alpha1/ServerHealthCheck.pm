package IO::K8s::Traefik::V1alpha1::ServerHealthCheck;
# ABSTRACT: Healthcheck defines health checks for ExternalName services.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s followRedirects   => Bool;
k8s headers           => { Str => 1 };
k8s hostname          => Str;
k8s interval          => IntOrStr;
k8s method            => Str;
k8s mode              => Str;
k8s path              => Str;
k8s port              => Int;
k8s scheme            => Str;
k8s status            => Int;
k8s timeout           => IntOrStr;
k8s unhealthyInterval => IntOrStr;

=attr followRedirects

FollowRedirects defines whether redirects should be followed during the health check calls.
Default: true

=cut

=attr headers

Headers defines custom headers to be sent to the health check endpoint.

=cut

=attr hostname

Hostname defines the value of hostname in the Host header of the health check request.

=cut

=attr interval

Interval defines the frequency of the health check calls for healthy targets.
Default: 30s

=cut

=attr method

Method defines the healthcheck method.

=cut

=attr mode

Mode defines the health check mode.
If defined to grpc, will use the gRPC health check protocol to probe the server.
Default: http

=cut

=attr path

Path defines the server URL path for the health check endpoint.

=cut

=attr port

Port defines the server URL port for the health check endpoint.

=cut

=attr scheme

Scheme replaces the server URL scheme for the health check endpoint.

=cut

=attr status

Status defines the expected HTTP status code of the response to the health check request.

=cut

=attr timeout

Timeout defines the maximum duration Traefik will wait for a health check request before considering the server unhealthy.
Default: 5s

=cut

=attr unhealthyInterval

UnhealthyInterval defines the frequency of the health check calls for unhealthy targets.
When UnhealthyInterval is not defined, it defaults to the Interval value.
Default: 30s

=cut

1;
