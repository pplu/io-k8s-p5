package IO::K8s::PrometheusOperator::V1alpha1::GCESDConfig;
# ABSTRACT: GCESDConfig configures scrape targets from GCP GCE instances.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s filter          => Str;
k8s port            => Int, { minimum => 0, maximum => 65535 };
k8s project         => Str, { required => 'schema' };
k8s refreshInterval => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s tagSeparator    => Str;
k8s zone            => Str, { required => 'schema' };

=attr filter

filter defines the filter that can be used optionally to filter the instance list by other criteria
Syntax of this filter is described in the filter query parameter section:
https://cloud.google.com/compute/docs/reference/latest/instances/list

=cut

=attr port

port defines the port to scrape metrics from. If using the public IP address, this must
instead be specified in the relabeling rule.

=cut

=attr project

project defines the Google Cloud Project ID

=cut

=attr refreshInterval

refreshInterval defines the time after which the provided names are refreshed.
If not set, Prometheus uses its default value.

=cut

=attr tagSeparator

tagSeparator defines the tag separator is used to separate the tags on concatenation

=cut

=attr zone

zone defines the zone of the scrape targets. If you need multiple zones use multiple GCESDConfigs.

=cut

1;
