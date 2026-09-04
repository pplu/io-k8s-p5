package IO::K8s::PrometheusOperator::V1alpha1::Filter;
# ABSTRACT: Filter name and value pairs to limit the discovery process to a subset of available resources.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name   => Str, { required => 'schema' };
k8s values => [Str], { required => 'schema' };

=attr name

name of the Filter.

=cut

=attr values

values defines values to filter on.

=cut

1;
