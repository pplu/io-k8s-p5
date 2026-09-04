package IO::K8s::PrometheusOperator::V1::TSDBSpec;
# ABSTRACT: tsdb defines the runtime reloadable configuration of the timeseries database(TSDB).
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s chunkEncoding                  => '+IO::K8s::PrometheusOperator::V1::ChunkEncodingSpec';
k8s outOfOrderTimeWindow           => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s staleSeriesCompactionThreshold => IntOrStr, { pattern => qr/^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$/ };

=attr chunkEncoding

chunkEncoding configures per-chunk-type encoding overrides.

It requires Prometheus >= v3.13.0.

Notice: Setting "Xor" is incompatible with --enable-feature=st-storage
(XOR chunks do not store start timestamps).

=cut

=attr outOfOrderTimeWindow

outOfOrderTimeWindow defines how old an out-of-order/out-of-bounds sample can be with
respect to the TSDB max time.

An out-of-order/out-of-bounds sample is ingested into the TSDB as long as
the timestamp of the sample is >= (TSDB.MaxTime - outOfOrderTimeWindow).

This is an *experimental feature*, it may change in any upcoming release
in a breaking way.

It requires Prometheus >= v2.39.0 or PrometheusAgent >= v2.54.0.

=cut

=attr staleSeriesCompactionThreshold

staleSeriesCompactionThreshold configures the trigger point for compacting
stale series from memory into persistent blocks and removing those stale
series from memory.

The threshold is a number between 0.0 and 1.0. It represents the ratio of
stale series in memory to the total series in memory. The stale series
compaction is triggered when this ratio crosses the configured threshold.
It may not trigger the stale series compaction if the usual head compaction
is about to happen soon.

If set to 0, stale series compaction is disabled.

It requires Prometheus >= v3.10.0.

=cut

1;
