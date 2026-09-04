package IO::K8s::PrometheusOperator::V1::Argument;
# ABSTRACT: Argument as part of the AdditionalArgs list.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name  => Str, { required => 'schema' };
k8s value => Str;

=attr name

name of the argument, e.g. "scrape.discovery-reload-interval".

=cut

=attr value

value defines the argument value, e.g. 30s. Can be empty for name-only
arguments (e.g. --storage.tsdb.no-lockfile)

=cut

1;
