package IO::K8s::PrometheusOperator::V1::MetadataConfig;
# ABSTRACT: metadataConfig defines how to send a series metadata to the remote storage.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s maxSamplesPerSend => Int, { minimum => -1 };
k8s send              => Bool;
k8s sendInterval      => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };

=attr maxSamplesPerSend

maxSamplesPerSend defines the maximum number of metadata samples per send.

It requires Prometheus >= v2.29.0.

=cut

=attr send

send defines whether metric metadata is sent to the remote storage or not.

The setting is ignored when Remote Write message's version 2.0 is used.

=cut

=attr sendInterval

sendInterval defines how frequently metric metadata is sent to the remote storage.

=cut

1;
