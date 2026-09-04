package IO::K8s::PrometheusOperator::V1alpha1::FileSDConfig;
# ABSTRACT: FileSDConfig defines a Prometheus file service discovery configuration See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#file_sd_config
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s files           => [Str], { required => 'schema', pattern => qr/^[^*]*(\*[^\/]*)?\.(json|yml|yaml|JSON|YML|YAML)$/ };
k8s refreshInterval => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };

=attr files

files defines the list of files to be used for file discovery. Recommendation: use absolute paths. While relative paths work, the
prometheus-operator project makes no guarantees about the working directory where the configuration file is
stored.
Files must be mounted using Prometheus.ConfigMaps or Prometheus.Secrets.

=cut

=attr refreshInterval

refreshInterval defines the time after which the provided names are refreshed.
If not set, Prometheus uses its default value.

=cut

1;
