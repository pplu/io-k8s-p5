package IO::K8s::PrometheusOperator::V1::RetainConfig;
# ABSTRACT: retain defines the config for retention when the retention policy is set to `Retain`.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s retentionPeriod => Str, { required => 'schema', pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };

=attr retentionPeriod

retentionPeriod defines how long the scaled-down shard(s) need to be
kept before being deleted.

=cut

1;
