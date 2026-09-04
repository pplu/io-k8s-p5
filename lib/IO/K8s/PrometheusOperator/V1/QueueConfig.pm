package IO::K8s::PrometheusOperator::V1::QueueConfig;
# ABSTRACT: queueConfig allows tuning of the remote write queue parameters.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s batchSendDeadline => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s capacity          => Int;
k8s maxBackoff        => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s maxRetries        => Int;
k8s maxSamplesPerSend => Int;
k8s maxShards         => Int;
k8s minBackoff        => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s minShards         => Int;
k8s retryOnRateLimit  => Bool;
k8s sampleAgeLimit    => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };

=attr batchSendDeadline

batchSendDeadline defines the maximum time a sample will wait in buffer.

=cut

=attr capacity

capacity defines the number of samples to buffer per shard before we start
dropping them.

=cut

=attr maxBackoff

maxBackoff defines the maximum retry delay.

=cut

=attr maxRetries

maxRetries defines the maximum number of times to retry a batch on recoverable errors.

=cut

=attr maxSamplesPerSend

maxSamplesPerSend defines the maximum number of samples per send.

=cut

=attr maxShards

maxShards defines the maximum number of shards, i.e. amount of concurrency.

=cut

=attr minBackoff

minBackoff defines the initial retry delay. Gets doubled for every retry.

=cut

=attr minShards

minShards defines the minimum number of shards, i.e. amount of concurrency.

=cut

=attr retryOnRateLimit

retryOnRateLimit defines the retry upon receiving a 429 status code from the remote-write storage.

This is an *experimental feature*, it may change in any upcoming release
in a breaking way.

=cut

=attr sampleAgeLimit

sampleAgeLimit drops samples older than the limit.
It requires Prometheus >= v2.50.0 or Thanos >= v0.32.0.

=cut

1;
