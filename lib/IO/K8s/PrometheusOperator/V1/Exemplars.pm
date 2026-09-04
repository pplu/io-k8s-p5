package IO::K8s::PrometheusOperator::V1::Exemplars;
# ABSTRACT: exemplars related settings that are runtime reloadable.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s maxSize => Int;

=attr maxSize

maxSize defines the maximum number of exemplars stored in memory for all series.

exemplar-storage itself must be enabled using the `spec.enableFeature`
option for exemplars to be scraped in the first place.

If not set, Prometheus uses its default value. A value of zero or less
than zero disables the storage.

=cut

1;
