package IO::K8s::Traefik::V1alpha1::Redis;
# ABSTRACT: Redis hold the configs of Redis as bucket in rate limiter.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s db             => Int;
k8s dialTimeout    => IntOrStr, { pattern => qr/^([0-9]+(ns|us|\x{b5}s|ms|s|m|h)?)+$/ };
k8s endpoints      => [Str];
k8s maxActiveConns => Int;
k8s minIdleConns   => Int;
k8s poolSize       => Int;
k8s readTimeout    => IntOrStr, { pattern => qr/^([0-9]+(ns|us|\x{b5}s|ms|s|m|h)?)+$/ };
k8s secret         => Str;
k8s tls            => '+IO::K8s::Traefik::V1alpha1::ClientTLS';
k8s writeTimeout   => IntOrStr, { pattern => qr/^([0-9]+(ns|us|\x{b5}s|ms|s|m|h)?)+$/ };

=attr db

DB defines the Redis database that will be selected after connecting to the server.

=cut

=attr dialTimeout

DialTimeout sets the timeout for establishing new connections.
Default value is 5 seconds.

=cut

=attr endpoints

Endpoints contains either a single address or a seed list of host:port addresses.
Default value is ["localhost:6379"].

=cut

=attr maxActiveConns

MaxActiveConns defines the maximum number of connections allocated by the pool at a given time.
Default value is 0, meaning there is no limit.

=cut

=attr minIdleConns

MinIdleConns defines the minimum number of idle connections.
Default value is 0, and idle connections are not closed by default.

=cut

=attr poolSize

PoolSize defines the initial number of socket connections.
If the pool runs out of available connections, additional ones will be created beyond PoolSize.
This can be limited using MaxActiveConns.
// Default value is 0, meaning 10 connections per every available CPU as reported by runtime.GOMAXPROCS.

=cut

=attr readTimeout

ReadTimeout defines the timeout for socket read operations.
Default value is 3 seconds.

=cut

=attr secret

Secret defines the name of the referenced Kubernetes Secret containing Redis credentials.

=cut

=attr tls

TLS defines TLS-specific configurations, including the CA, certificate, and key,
which can be provided as a file path or file content.

=cut

=attr writeTimeout

WriteTimeout defines the timeout for socket write operations.
Default value is 3 seconds.

=cut

1;
