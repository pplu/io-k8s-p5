package IO::K8s::PrometheusOperator::V1::AlertmanagerLimitsSpec;
# ABSTRACT: limits defines the limits command line flags when starting Alertmanager.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s maxPerSilenceBytes => Str, { pattern => qr/(^0|([0-9]*[.])?[0-9]+((K|M|G|T|E|P)i?)?B)$/ };
k8s maxSilences        => Int, { minimum => 0 };

=attr maxPerSilenceBytes

maxPerSilenceBytes defines the maximum size of an individual silence as stored on disk. This corresponds to the Alertmanager's
`--silences.max-per-silence-bytes` flag.
It requires Alertmanager >= v0.28.0.

=cut

=attr maxSilences

maxSilences defines the maximum number active and pending silences. This corresponds to the
Alertmanager's `--silences.max-silences` flag.
It requires Alertmanager >= v0.28.0.

=cut

1;
