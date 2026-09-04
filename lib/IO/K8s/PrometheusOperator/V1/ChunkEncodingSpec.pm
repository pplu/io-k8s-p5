package IO::K8s::PrometheusOperator::V1::ChunkEncodingSpec;
# ABSTRACT: chunkEncoding configures per-chunk-type encoding overrides.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s floats => Str, { enum => [qw(Xor Xor2)] };

=attr floats

floats selects the encoding used for float chunks.
Valid values are "Xor" and "Xor2".

Notice:
 * Setting "Xor" is incompatible with --enable-feature=st-storage
(XOR chunks do not store start timestamps).
 * Setting "Xor2" automatically adds the `xor2-encoding` feature flag.

It requires Prometheus >= v3.13.0.

=cut

1;
