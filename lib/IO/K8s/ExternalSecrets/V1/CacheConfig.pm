package IO::K8s::ExternalSecrets::V1::CacheConfig;
# ABSTRACT: Cache configures client-side caching for read operations (GetSecret, GetSecretMap).
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s maxSize => Int, { minimum => 1, default => 100 };
k8s ttl     => Str, { default => '5m' };

=attr maxSize

MaxSize is the maximum number of secrets to cache.
When the cache is full, least-recently-used entries are evicted.

=cut

=attr ttl

TTL is the time-to-live for cached secrets.
Format: duration string (e.g., "5m", "1h", "30s")

=cut

1;
